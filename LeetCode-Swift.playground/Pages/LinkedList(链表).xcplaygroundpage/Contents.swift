//: [Previous](@previous)

import Foundation


class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode: CustomStringConvertible {
    var description: String {
        var node:ListNode? = self
        var str = ""
        while node != nil {
            str += "\(node!.val)->"
            node = node?.next
        }
        return str
    }
}

//MARK: LeetCode 第 86 号问题：分割链表
//: 输入: head = 1->4->3->2->5->2, x = 3  输出: 1->2->2->4->3->5

/*
 思路： 时间复杂度 O(N) 空间复杂度为O(1) 类似于双指针
 设定两个虚拟节点，dummyHead1用来保存小于于该值的链表，
 dummyHead2来保存大于等于该值的链表
 遍历整个原始链表，将小于该值的放于dummyHead1中，其余的放置在dummyHead2中
 遍历结束后，将dummyHead2插入到dummyHead1后面
 */


//MARK: 反转链表
/*
 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 */
//递归法
func reverseList(_ head: ListNode?) -> ListNode? {
  guard let h = head, let next = h.next else {
      return head
  }

  let node = reverseList(next)

  next.next = h
  h.next = nil

  return node
}
//头差法
func reverseList1(_ head: ListNode?) -> ListNode? {
    var pre: ListNode?
    var head = head
    
    while head != nil {
        let next = head!.next;
        head!.next = pre
        pre = head
        head = next
    }
    return pre
}


let n1 = ListNode(1)
let n2 = ListNode(2)
let n3 = ListNode(3)
let n4 = ListNode(4)
let n5 = ListNode(5)
n1.next = n2
n2.next = n3
n3.next = n4
n4.next = n5

print(n1)

//MARK: 设计链表





//: [Next](@next)
