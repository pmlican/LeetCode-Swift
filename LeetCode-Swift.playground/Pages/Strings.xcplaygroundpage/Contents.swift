//: [Previous](@previous)

import Foundation


//MARK:反转字符串
//不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
//输入：["h","e","l","l","o"]
//输出：["o","l","l","e","h"]

// 双指针解决，头尾交换
func reverseString(_ s: inout [Character]) {
    var left = 0
    var right = s.count - 1
    while left < right {
        //可以用中间变量交互，或者swap函数，或者用元组交换
        (s[right],s[left]) = (s[left],s[right])
        left += 1
        right -= 1
    }
}

var hello = Array("hello")
reverseString(&hello)

//: [Next](@next)
