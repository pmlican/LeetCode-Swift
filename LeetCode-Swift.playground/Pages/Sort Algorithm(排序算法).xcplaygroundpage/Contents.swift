//: [Previous](@previous)

/*:
 * Callout(常用的排序算法实现):
 [动态演示](http://www.algomation.com/player?algorithm=58bb32885b2b830400b05123)
 [动图演示](http://www.mathcs.emory.edu/~cheung/Courses/171/Syllabus/7-Sort/merge-sort5.html)
 
 1.基本的排序：插入排序，选择排序，希尔排序
 
 2.快速的排序：快速排序，归并排序，堆排序
 
 3.混合的排序：内省排序
 
 4.特殊的排序：计数排序，基数排序，拓扑排序
 
 5.不好的排序：冒泡排序，慢排序
 */

import Foundation

//: 插入排序,时间复杂度，最坏情况是O(n^2),最好的情况是O(n)（因为当数组本身就是有序的情况）,是稳定排序（稳定排序是只相同元素，排序后位置不改变，对于元素为Int和String类型并无影响，但对于元素为对象是影响较大）

/*
 思路：类似于打牌抽卡牌一样，做一个标记，不断向右移动，右边元素比较大小，如下图演示过程
 [| 8, 3, 5, 4, 6 ]
 [ 8 | 3, 5, 4, 6 ]
 [ 3, 8 | 5, 4, 6 ]
 [ 3, 5, 8 | 4, 6 ]
 [ 3, 4, 5, 8 | 6 ]
 [ 3, 4, 5, 6, 8 |]
*/
//MARK: 插入排序
func insertSort(_ array:[Int]) -> [Int] {
    var a = array
    for i in 1..<a.count {
        var j = i
        let temp = a[j]
        while j > 0 && temp < a[j - 1] {
            a[j] = a[j - 1]
            j -= 1
        }
        a[j] = temp
    }
    return a
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertSort(list)


//MARK: 快速排序

//: 快速排序是最快速的原地排序方案
//Lomuto 分区方案，循环过程把数组分成4个区域
//a[low...i] 包含小于支点的元素
//a[i+1...j-1] 包含大于支点的元素
//a[j...high-1] 还没查看的元素
//a[high] 支点元素
//整个个分区方案有个小缺点，当如果有很多重复元素，它会使排序变慢
/*
 [| 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]
 low                                       high
 i
 j
 [| 10 | 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]
 low                                        high
 i
     j
 [ 0 | 10 | 3, 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]
 low                                         high
     i
          j
 [ 0, 3 | 10 | 9, 2, 14, 26, 27, 1, 5, 8, -1 | 8 ]
 low                                         high
        i
            j
 [ 0, 3, 2, 1, 5, 8, -1 | 8 | 9, 10, 14, 26, 27 ]
 low                                       high
                        i                  j
[ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ] 选择最后一个为支点分区后得到
[ 0, 3, 2, 1, 5, 8, -1, 8, 9, 10, 14, 26, 27 ]
 */

func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            (a[i], a[j]) = (a[j], a[i])
            i += 1
        }
    }
    (a[i], a[high]) = (a[high], a[i])
    return i
}

func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: p - 1)
        quicksortLomuto(&a, low: p + 1, high: high)
    }
}
var list1 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
//let p = partitionLomuto(&list1,low:0, high: list1.count - 1)
//list1
quicksortLomuto(&list1, low: 0, high: list1.count - 1)

//hoare分区方案比lomuto方案交换元素次数少一点,从左边往右， 从右边向左查找，当元素小于pivot（支点）时交换位置， 所以整个循环下来，j为数组中间，划分为两个分区，左边是小于支点，右边是大于支点的元素
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let piovt = a[low]
    var i = low - 1
    var j = high + 1
    while true {
        repeat { j -= 1 } while a[j] > piovt
        repeat { i += 1 } while a[i] < piovt
        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}

// [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ] 选择第一个作为分区支点得到
// [ -1, 0, 3, 8, 2, 5, 1, 27, 10, 14, 9, 8, 26 ]

var list2 = [ 8, 0, 3, 9, 2, 14, 10, 27, 1, 5, 8, -1, 26 ]
let p2 = partitionHoare(&list2, low: 0, high: list2.count - 1)
//list2

//因为 low到p的是小于支点的元素， p+1到high是大于支点的元素，所以稍微与lomuto分区有点不同
func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p+1, high: high)
    }
}

quicksortHoare(&list2, low: 0, high: list2.count - 1)

// 如何选择一个好的支点，一种是三个中间值，一种是随机取值
//One trick is "median-of-three", where you find the median of the first, middle, and last element in this subarray. In theory that often gives a good approximation of the true median.

//Another common solution is to choose the pivot randomly. Sometimes this may result in choosing a suboptimal pivot but on average this gives very good results.
public func random(min: Int, max: Int) -> Int {
  assert(min < max)
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
//        let pivotIndex = random(min: low, max: high)
        let pivotIndex = Int.random(in: low...high)
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        
        let p = partitionLomuto(&a, low: low, high: high)
        quicksortRandom(&a, low: low, high: p-1)
        quicksortRandom(&a, low: p+1, high: high)
    }
}

var list3 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
quicksortRandom(&list3, low: 0, high: list3.count - 1)


//: 百度百科示例代码

func quickSort(a: inout [Int], low: Int, high: Int) {
    if low >= high {
        return
    }
    var i = low
    var j = high
    let key = a[i]
    while i < j {
        while i < j && a[j] > key {
            j -= 1
        }
        a[i] = a[j]
        while i < j && a[i] <= key{
            i += 1
        }
        a[j] = a[i]
    }
    a[i] = key
    quickSort(a: &a, low: low, high: i - 1)
    quickSort(a: &a, low: i + 1, high: high)
}

var m = [2,3,5,7,1,4,6,15,5,2,7,9,10,15,9,17,12]
quickSort(a: &m, low: 0, high: m.count - 1)
print(m)


//荷兰分区，如果包含重复元素，使用这种方式分区提高效率
//swift 自带的swap 当两个索引引用相同的元素时，不会产生错误
func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
    if i != j {
        a.swapAt(i, j)
    }
}
func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    
    while equal <= larger {
        if a[equal] < pivot {
            swap(&a, smaller, equal)
            smaller += 1
            equal += 1
        } else if a[equal] == pivot {
            equal += 1
        } else {
            swap(&a, equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}

func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
  if low < high {
    let pivotIndex = Int.random(in: low...high)
    let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
    quicksortDutchFlag(&a, low: low, high: p - 1)
    quicksortDutchFlag(&a, low: q + 1, high: high)
  }
}


var list4 = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
//指定支点的index
partitionDutchFlag(&list4, low: 0, high: list4.count - 1, pivotIndex: 10)
list4

//MARK: 选择排序
//每次循环选择最小的放在前面
func selectionSort(arr: inout [Int]) {
    
    let count = arr.count
    for i in 0..<count-1 {
        var minIndex = i
        for j in (i+1)..<count {
            if arr[minIndex] > arr[j] {
                minIndex = j
            }
        }
        if i != minIndex {
            //交换两个数位置,利用元组交换位置 或者 用一个中间变量 或者用swapAt方法
//            (arr[minIndex], arr[i]) = (arr[i], arr[minIndex])
            // a.swapAt(x, lowest)

            let temp = arr[i]
            arr[i] = arr[minIndex]
            arr[minIndex] = temp
        }
    }
}

var testSelectionArr = [3,4,1,6,3,10,9,7]
selectionSort(arr: &testSelectionArr)

//MARK:冒泡排序
//每个元素相邻比较
func bubbleSort(arr: inout [Int]) {
    let count = arr.count
    for i in 0..<count {
        for j in 1..<count-i {
            if arr[j] < arr[j - 1] {
                let temp = arr[j-1]
                arr[j-1] = arr[j]
                arr[j] = temp
            }
        }
    }
}
var testBubbleArr = [3,4,1,6,3,10,9,7]
bubbleSort(arr: &testBubbleArr)

//MARK:归并排序

//递归有点容易理解，缺点会导致堆栈溢出，堆栈溢出的产生是由于过多的函数调用，导致调用堆栈无法容纳这些调用的返回地址
//bottomToTop 自下而上，非递归，用双缓冲解决

/*
 a                                  6   5   7   2   8   4   9   1
 大小为1的相邻数组的合并对              5 6    |   2 7 |  4 8  | 1  9
 大小为2的相邻数组的合并对              2 5 6 7        |  1 4 8 9
 大小为4的相邻数组的合并对              1  2  4 6 7 8 9
 */

func mergeSort1(arr: [Int]) -> [Int] {
    let n = arr.count
    var width = 1
    //双缓冲二维数组，index=0 读取， index=1 写入
    var z = [arr, arr]
    // [1-d]写入 d读取
    var d = 0
    
    while width < n {
        var i = 0
        while i < n {
            //定义三个标记，l为左堆索引，r为右堆索引，j记录当前检查的标记
            var j = i
            var l = i
            var r = i + width
            let lmax = min(l + width, n)
            let rmax = min(r + width, n)
            
            while l < lmax && r < rmax {
                if z[d][l] < z[d][r] {
                    z[1-d][j] = z[d][l]
                    l += 1
                } else {
                    z[1-d][j] = z[d][r]
                    r += 1
                }
                j += 1
            }
            while l < lmax {
                z[1-d][j] = z[d][l]
                j += 1
                l += 1
            }
            while r < rmax {
                z[1-d][j] = z[d][r]
                j += 1
                r += 1
            }
            i += width*2
        }
        
        //二分缩小数组
        width *= 2
        d = 1 - d
    }
    
    return z[d]
}



//topToBottom 自上而下，递归，容易理解

func mergeSort2(arr: [Int]) -> [Int] {
    //递归出口
    guard arr.count > 1 else {return arr}
    
    let m = arr.count / 2
    
    let l = mergeSort2(arr: Array(arr[0..<m]))
    let r = mergeSort2(arr: Array(arr[m..<arr.count]))
    
    return merge(lPie: l, rPie: r)
    
}

func merge(lPie: [Int], rPie: [Int]) -> [Int] {
    
    var l = 0
    var r = 0
    
    var a = [Int]()
    a.reserveCapacity(lPie.count + rPie.count)
    
    while l < lPie.count && r < rPie.count {
        if lPie[l] < rPie[r] {
            a.append(lPie[l])
            l += 1
        } else if lPie[l] > rPie[r] {
            a.append(rPie[r])
            r += 1
        } else {
            a.append(lPie[l])
            l += 1
            a.append(rPie[r])
            r += 1
        }
    }
        
    while l < lPie.count {
        a.append(lPie[l])
        l += 1
    }
    
    while r < rPie.count {
        a.append(rPie[r])
        r += 1
    }
    
    return a
}

let mergeTestArr = [3,4,1,6,3,10,9,7]

let mergeArr2 = mergeSort2(arr: mergeTestArr)

let mergeArr1 = mergeSort1(arr: mergeTestArr)


//: [Next](@next)
