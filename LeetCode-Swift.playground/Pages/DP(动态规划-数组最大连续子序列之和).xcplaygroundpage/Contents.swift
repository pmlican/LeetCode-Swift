//: [Previous](@previous)

import Foundation

/*:
 - callout
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 输入: [-2,1,-3,4,-1,2,1,-5,4],
 输出: 6
 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。

 */

//方法一：暴力算法，时间复杂度O(n^2)

func maxSubArray1(arr: [Int]) -> Int {
    let count = arr.count
    var maxSum = 0
    for i in 0..<count {
        var maxTemp = 0
        for j in i..<count {
            maxTemp += arr[j]
            if maxTemp > maxSum {
                maxSum = maxTemp
            }
        }
    }
    return maxSum
}


//方法二：动态规划，状态转义方程dp[i] = max(dp[i-1] + nums[i], nums[i])
//时间复杂度O(n)
func maxSubArray(arr:[Int]) -> Int {
    var sum = arr[0]
    var maxium = arr[0]
    for i in 1..<arr.count {
        sum = max(sum + arr[i], arr[i])
        if maxium < sum {
            maxium = sum
        }
    }
    return maxium
}


let arr = [-2,1,-3,4,-1,2,1,-5,4]
maxSubArray(arr: arr)
maxSubArray1(arr: arr)

//: [Next](@next)
