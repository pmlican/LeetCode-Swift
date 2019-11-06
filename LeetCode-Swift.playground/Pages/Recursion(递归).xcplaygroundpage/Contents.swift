//: [Previous](@previous)

import Foundation

//MARK:递归解题

//:两两交换链表中的节点 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
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

//速度比较快的迭代，一样，只不过用了强制解包性能好点
func swapPairs3(_ head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil {
        return head
    }
    var first = head
    var second = head!.next!
    var third = second.next
    second.next = first
    first!.next = swapPairs(third)
    return second
}

//迭代解法,时间复杂度为O(N),空间复杂度为O(1)
func swapPairs1(_ head: ListNode?) -> ListNode? {
 
    var dummyHead: ListNode? = ListNode.init(-1)
    dummyHead?.next = head
    
    var prev = dummyHead
    
    while prev?.next != nil && prev?.next?.next != nil {
        let tmp = prev?.next
        let tail = prev?.next?.next
        
        prev?.next = tail
        tmp?.next = tail?.next
        tail?.next = tmp
        
        prev = prev?.next?.next
    }
    
    return dummyHead?.next
}


//: [Next](@next)
