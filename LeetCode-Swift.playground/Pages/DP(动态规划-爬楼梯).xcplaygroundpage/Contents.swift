/*:
 
 # 动态规划：爬楼梯
 ### 70. Climbing Stairs (Easy)
 最佳解释：[参考文章](https://segmentfault.com/a/1190000015944750)
 #### 动态规划概念:
 动态规划(dynamic programming)是运筹学的一个分支，是求解决策过程(decision process)最优化的数学方法。动态规划算法通常基于一个递推公式及一个或多个初始状态。 当前子问题的解将由上一次子问题的解推出。
 要解决一个给定的问题，我们需要解决其不同部分（即解决子问题），再合并子问题的解以得出原问题的解。
 通常许多子问题非常相似，为此动态规划法试图只解决每个子问题一次，从而减少计算量。
 一旦某个给定子问题的解已经算出，则将其记忆化存储，以便下次需要同一个子问题解之时直接查表。
 这种做法在重复子问题的数目关于输入的规模呈指数增长时特别有用。
 #### 动态规划有三个核心元素
 1. 最优子结构
 2. 边界
 3. 状态转移方程

 */


import UIKit


//: 题目描述：有 N 阶楼梯，每次可以上一阶或者两阶，求有多少种上楼梯的方法。
/*
 思路：0到10级台阶的所有走法 x + y
 
 1->2->2->1->1->1->1        |  -> 1
 2->1->2->2->1->1           |  -> 1
 ......                     |  -> 1
 ......  0到9级台阶所有走法x   |  -> 1
 ------------------------------------
 1->2->1->1->1->1->1        |  -> 2
 1->1->1->2->1->1->1        |  -> 2
 ......                     |  -> 2
 ......  0到8级台阶的所有走法y  |  -> 2

 因为最后一步要么走2个台阶，要么走1个台阶
 所以总数为 f(n) = f(n-1) + f(n-2)
 两个初始状态: f(1) = 1, f(2) = 2
 */

/*
 方法一： 递归求解 时间复杂度为 O(2^n)
      f(n)
  /            \
 f(n-1)         f(n-2)
 /     \        /    \
f(n-2) f(n-3)  f(n-3)  f(n-4)
 
 缺点是： 很多重复计算，如上图 f(n-2)， f(n-3) 被重复计算
*/
func climbStairs1(n: Int) -> Int {
    if n < 1 {return 0}
    if n == 1 {return 1}
    if n == 2 {return 2}
    return climbStairs1(n: n-1) + climbStairs1(n: n-2)
}


/*
 解决方法一： 备忘录算法
 
 最终dict存放n-2个键值对 所以空间复杂度为O(n),时间复杂度也为O(n)
 */
var dict = [Int: Int]()
func climbStairs2(n: Int) -> Int {
    if n < 1 {return 0}
    if n == 1 {return 1}
    if n == 2 {return 2}
    if let v = dict[n] {
        return v
    }
    let value = climbStairs2(n: n - 1) + climbStairs2(n: n-2)
    dict[n] = value
    return value
}


/*
----------------------------------------------
台阶数| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10
----------------------------------------------
走法数| 1 | 2 | 3 | 5 |
 
 只要每次迭代前两个数据，相加就等于当前数据 例如 台阶数为4 = 台阶数3 + 台阶数2
 时间复杂度为O(n),但空间复杂度为O(1)
*/

func climbStairs3(n: Int) -> Int {
    if n < 1 {return 0}
    if n == 1 {return 1}
    if n == 2 {return 2}
    var a = 1, b = 2
    var temp = 0
    for _ in stride(from: 3, through: n, by: 1) {
        temp = a + b
        a = b
        b = temp
    }
    return temp
}

climbStairs1(n: 10)
climbStairs2(n: 10)
climbStairs3(n: 10)
//print(dict)


/*:
 [Table of Contents](Table%20of%20Contents) | [上一页](@previous) | [下一页](@next)
 */
