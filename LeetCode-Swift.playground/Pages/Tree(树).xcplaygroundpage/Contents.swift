//: [Previous](@previous)

import Foundation

/*
 输入: [1,null,2,3]
    1
     \
      2
     /
    3

 输出: [1,2,3]
 使用前序遍历
 */

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

func preorderTraversal(_ root: TreeNode?) -> [Int] {
    var arr = [Int]()
    helper(node: root, arr: &arr)
    return arr
}
//前序
func helper(node: TreeNode?,arr: inout [Int]) {
    if node == nil {return}
    arr.append(node!.val)
    helper(node: node?.left, arr: &arr)
    helper(node: node?.right, arr: &arr)
}
//中序
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var arr = [Int]()
    helper1(node: root, arr: &arr)
    return arr
}
func helper1(node: TreeNode?,arr: inout [Int]) {
    if node == nil {return}
    helper1(node: node?.left, arr: &arr)
    arr.append(node!.val)
    helper1(node: node?.right, arr: &arr)
}

//后序
func postOrderTraversal(_ root: TreeNode?) -> [Int] {
    var arr = [Int]()
    helper2(node: root, arr: &arr)
    return arr
}
func helper2(node: TreeNode?,arr: inout [Int]) {
    if node == nil {return}
    helper2(node: node?.left, arr: &arr)
    helper2(node: node?.right, arr: &arr)
    arr.append(node!.val)
}

//写法二
func inorderTraversal1(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    
    if let left = root?.left {
        result += inorderTraversal(left)
    }

    if let root = root {
     result.append(root.val)
    }

    if let right = root?.right {
        result += inorderTraversal(right)
    }

    return result
}
//写法三
func postorderTraversal1(_ root: TreeNode?) -> [Int] {
    // Recursion terminator
    guard root != nil else { return [] }
    // Process current level & Drill down
    return postorderTraversal1(root!.left) + postorderTraversal1(root!.right) + [root!.val]
}

let root = TreeNode(1)
let node1 = TreeNode(2)
let node2 = TreeNode(3)
root.right = node1
node1.left = node2

let res = postOrderTraversal(root)
print(res)



//层序遍历：广度优先搜索是一种广泛运用在树或图这类数据结构中，遍历或搜索的算法。 该算法从一个根节点开始，首先访问节点本身。 然后遍历它的相邻节点，其次遍历它的二级邻节点、三级邻节点，以此类推。
/*
 题目二叉树层次遍历
   3
  / \
 9  20
   /  \
  15   7
 结果：
 [
   [3],
   [9,20],
   [15,7]
 ]
 */
//二叉树的层次遍历其实就是图的广度优先遍历BFS(Breadth-First-Search)
//用队列解决
func levelOrder(_ root: TreeNode?) -> [Int] {
    guard root != nil else {
        return []
    }
    var res = [Int]()
    var queue = [TreeNode]()
    queue.append(root!)
    while !queue.isEmpty {
        let node = queue.removeFirst()
        if let left = node.left {
            queue.append(left)
        }
        if let right = node.right {
            queue.append(right)
        }
        res.append(node.val)
    }
    return res
}
func levelOrder1(_ root: TreeNode?) -> [[Int]] {
    guard root != nil else {return []}
    var queue = [TreeNode]()
    var res = [[Int]]()
    queue.append(root!)
    while !queue.isEmpty {
        let size = queue.count
        var level = [Int]()
        for _ in 0..<size {
            let node = queue.removeFirst()
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append(level)
    }
    return res
}
//递归解法
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  var res: [[Int]] = []
  func what(root: TreeNode?, level: Int) {
    guard let rootNode = root else { return }
    if level >= res.count {
      res.append([rootNode.val])
    } else {
      res[level].append(rootNode.val)
    }
    let left = rootNode.left
    let right = rootNode.right
    let nextLevel = level + 1
    what(root: left, level: nextLevel)
    what(root: right, level: nextLevel)
  }
  what(root: root, level: 0)
  return res
}

/*
   3
  / \
 9  20
   /  \
  15   7
 最大深度为3
 */
// downToTop
func maxDepth(_ root: TreeNode?) -> Int {
    if root == nil {return 0}
    return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
}

//topToDown
var answer = 0
func maxDepth1(_ root: TreeNode?, depth: Int) {
    if root == nil {return}
    if root?.left == nil && root?.right == nil {
        answer = max(answer, depth)
    }
    maxDepth1(root?.left, depth: depth + 1)
    maxDepth1(root?.right, depth: depth + 1)
}

func test(_ root: TreeNode?) ->  Int {
    var answer = 0
    maxDepth1(root, depth: 1, answer: &answer)
    return answer
}

//var answer = 0
func maxDepth1(_ root: TreeNode?, depth: Int, answer: inout Int) {
    if root == nil {return}
    if root?.left == nil && root?.right == nil {
        answer = max(answer, depth)
    }
    maxDepth1(root?.left, depth: depth + 1, answer: &answer)
    maxDepth1(root?.right, depth: depth + 1, answer: &answer)
}

let tNode = TreeNode(3)
let tNode2 = TreeNode(9)
let tNode3 = TreeNode(20)
let tNode4 = TreeNode(15)
let tNode5 = TreeNode(7)
let tNode6 = TreeNode(6)


tNode.left = tNode2
tNode.right = tNode3
tNode3.left = tNode4
tNode3.right = tNode5
tNode5.left = tNode6

maxDepth1(tNode,depth: 1)
maxDepth(tNode)
print(answer)

//: [Next](@next)
