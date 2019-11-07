//: [Previous](@previous)

import Foundation

//MARK:递归解题 两两交换链表中的节点

//: 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
// 1->2->3->4   =>  2->1->4->3
//要两两交换

//单链表
class ListNode {
    var next: ListNode?
    var val: Int
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
extension ListNode: CustomStringConvertible {
    var description: String {
        var s = ""
        s += "\(val)->"
        var node = self
        while let n = node.next {
            s += "\(n.val)"
            node = n
            if node.next != nil {
                s += "->"
            }
        }
        return s
    }
}

//递归解法，时间复杂度为O(N),空间为O(N),
func swapPairs(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil  {
        return head
    }
    let next = head?.next
    head?.next = swapPairs(next?.next)
    next?.next = head
    return next
}

/*

一开始加个pre指针：  pre  ->  1 ->  2 - > 3
                _____②___________________
               /                          \/
   pre         a                   b      b.next
   -1  -①/>    1    -②/>  <-③    2  ->  3
    \_________①___________________/\
   
 调整之后:   pre->2->1->3
 pre 移动到3的位置  =》 tmp = tmp.next!.next!
 
 */

//迭代解法,时间复杂度为O(N),空间复杂度为O(1)
//思路如上图
func swapPairs1(_ head: ListNode?) -> ListNode? {
    let pre = ListNode(-1)
    pre.next = head
    var tmp = pre
    while tmp.next != nil || tmp.next?.next != nil {
        let a = tmp.next
        let b = tmp.next?.next
        tmp.next = b
        a?.next = b?.next
        b?.next = a
        tmp = tmp.next!.next!
    }
    return pre.next
}


let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)

node1.next = node2
node2.next = node3
node3.next = node4

print(node1)

let n1 = swapPairs(node1)
print(n1)

let n2 = swapPairs1(n1)
print(n2)



//MARK:打印杨辉三角




//: [Next](@next)
