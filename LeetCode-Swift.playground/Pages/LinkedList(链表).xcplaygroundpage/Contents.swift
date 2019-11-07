//: [Previous](@previous)

import Foundation


//MARK: LeetCode 第 86 号问题：分割链表
//: 输入: head = 1->4->3->2->5->2, x = 3  输出: 1->2->2->4->3->5

/*
 思路： 时间复杂度 O(N) 空间复杂度为O(1) 类似于双指针
 设定两个虚拟节点，dummyHead1用来保存小于于该值的链表，
 dummyHead2来保存大于等于该值的链表
 遍历整个原始链表，将小于该值的放于dummyHead1中，其余的放置在dummyHead2中
 遍历结束后，将dummyHead2插入到dummyHead1后面
 */


let n = ListNode(1)


//: [Next](@next)
