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

//MARK:题目一：二叉树，前序，中序，后序遍历
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

let resInorder = inorderTraversal(root)
let resPreOrder = preorderTraversal(root)
let resPostOrder = postOrderTraversal(root)

//MARK: 题目二：二叉树层序遍历
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

//MARK:题目三：求二叉树最大深度
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

//MARK:题目四： 判断二叉树是否对称
/*
     1
    / \
   2   2
  / \ / \
 3  4 4  3   对称
  1
  / \
 2   2
  \   \
  3    3      不对称
 */
//递归解法： 1.递归的子问题是什么 2.递归结束条件是什么

//判断二叉树是否对称
func isSymmetric(_ root: TreeNode?) -> Bool {
    return root == nil || symmetricHelper(root?.left,root?.right)
}

func symmetricHelper(_ left: TreeNode?,_ right: TreeNode?) -> Bool {
    //递归出口
    if left == nil && right == nil {
        return true
    }
    if left == nil || right == nil {
        return false
    }
    //子问题: 检查左子树的左叶子是否与右子树右叶子相等，并且左子树右叶子是否与右子树左叶子相等
    return (left?.val == right?.val) && symmetricHelper(left?.left, right?.right) && symmetricHelper(left?.right, right?.left)
}

//迭代方法 用层序遍历法，利用一个辅助队列
func isSymmertric(_ root: TreeNode?) -> Bool{
    var queue = [TreeNode?]()
    queue.append(root?.left)
    queue.append(root?.right)
    while !queue.isEmpty {
        let left = queue.removeFirst()
        let right = queue.removeFirst()
        if left == nil && right == nil {continue}
        if left == nil || right == nil {return false}
        if left?.val != right?.val  {return false}
        queue.append(left?.left)
        queue.append(right?.right)
        queue.append(left?.right)
        queue.append(right?.left)
    }
    return true
}

//MARK:题目五：路径总和
/*
       5
      / \
     4   8
    /   / \
   11  13  4
  /  \      \
 7    2      1
 存在目标和为 22 的根节点到叶子节点的路径 5->4->11->2
 */
//递归方法
func hasPathSum(_ root: TreeNode?,_ sum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        if root.val == sum, root.left == nil, root.right == nil {
            return true
        }
        let target = sum - root.val
        //递归求解左右节点的剩余值
        return hasPathSum(root.left, target) || hasPathSum(root.right, target)
}

//迭代方法,用栈将递归转成迭代的形式
//我们可以用栈将递归转成迭代的形式。深度优先搜索在除了最坏情况下都比广度优先搜索更快。最坏情况是指满足目标和的 root->leaf 路径是最后被考虑的，这种情况下深度优先搜索和广度优先搜索代价是相通的。
func hasPathSum1(_ root: TreeNode?, sum: Int) -> Bool {
    guard let root = root else {
        return false
    }
    //初始化把根节点作为第一个元素初始化栈
    var stack = [(root, sum - root.val)]
    while !stack.isEmpty {
        let (node, currentSum) = stack.removeLast()
        if node.left == nil && node.right == nil && currentSum == 0 {
            return true
        }
        if let right = node.right {
            stack.append((right, currentSum - right.val))
        }
        if let left = node.left {
            stack.append((left, currentSum - left.val))
        }
    }
    return false
}

//MARK: 补充:广度优先（BFS:Breadth First Search),深度优先（DFS:Depth First Search）

/*
 深度优先遍历：从根节点出发，沿着左子树方向进行纵向遍历，直到找到叶子节点为止。然后回溯到前一个节点，进行右子树节点的遍历，直到遍历完所有可达节点为止。

 广度优先遍历：从根节点出发，在横向遍历二叉树层段节点的基础上纵向遍历二叉树的层次。
 这两种可以用来遍历树和图
 用树来作例子：
         A
       /    \
      B      C
     /  \   /  \
    D   E  F    G
 DFS => ABDECFG
 BFS => ABCDEFG
 
 DFS: 用栈来实现，父节点入栈，循环里进行，栈pop, 先右子节点入栈，后左子节点入栈
 BFS: 用队列来实现，父节点入队,循环里进行，出队, 先 左子节点入队，后右子节点入队
 
*/

func BFS(_ root: TreeNode) -> [Int] {
    var queue = [root]
    var res = [Int]()
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

//这种写法DFS深度优先-前序遍历
func DFS(_ root: TreeNode) -> [Int] {
    var stack = [root]
    var res = [Int]()
    while !stack.isEmpty {
        let node = stack.removeLast()
        if let right = node.right {
            stack.append(right)
        }
        if let left = node.left {
            stack.append(left)
        }
        res.append(node.val)
    }
    return res
}
//这种写法DFS深度优先-中序遍历
func DFS1(_ root: TreeNode?) -> [Int] {
    var stack = [TreeNode]()
    var node = root
    var res = [Int]()
    while node != nil || !stack.isEmpty {
        while let n = node {
            stack.append(n)
            node = node?.left
        }
        node = stack.removeLast()
        res.append(node!.val)
        node = node?.right
    }
    return res
}

//这种写法DFS深度优先-后序序遍历
func DFS2(_ root: TreeNode) -> [Int] {
    var stack = [root]
    var res = [Int]()
    while !stack.isEmpty {
        let node = stack.removeLast()
        res.insert(node.val, at: 0)
        if let left = node.left {
            stack.append(left)
        }
        if let right = node.right {
            stack.append(right)
        }
    }
    return res
}

/*
    1
   /  \
  2    3
 /  \  / \
4   5  6  7
 
BFS  [1, 2, 3, 4, 5, 6, 7]
DFS  [1, 2, 4, 5, 3, 6, 7]
 
                    DFS(分为后序，前序，中序)
 Postorder                Preorder                inorder
 left->right->root    root->left->right       left->root->right
      5                    1                     4
    /   \                /   \                 /    \
   3     4              2     5               2      5
  /  \                /   \                  /  \
 1    2              3    4                 1    3

 */

let BFS1 = TreeNode(1)
let BFS2 = TreeNode(2)
let BFS3 = TreeNode(3)
let BFS4 = TreeNode(4)
let BFS5 = TreeNode(5)
let BFS6 = TreeNode(6)
let BFS7 = TreeNode(7)
BFS1.left = BFS2
BFS1.right = BFS3
BFS2.left = BFS4
BFS2.right = BFS5
BFS3.left = BFS6
BFS3.right = BFS7

print(BFS(BFS1))
print(DFS(BFS1))
print("前序遍历",preorderTraversal(BFS1))
print("中序遍历",inorderTraversal(BFS1))
print("后序遍历",postOrderTraversal(BFS1))

//MARK: 构建二叉树

/*
 构建二叉树一定要有中序数组，因为中序确定左右子树
 前序和后序，可以确定根节点
 然后递归解决子问题
      - *  =  = =
 中序  9 3 15 20 7
 
      - =  = =  *
 后序  9 15 7 20 3
      * - =  =  =
 先序  3 9 20 15 7
 
 *代表根节点
 -代表左子树节点
 =代表右子树节点
 
 然后继续递归分下去得到树结构如图
    3
  /   \
 9    20
     /  \
    15   7
 */

//第一题：根据后序和中序构建二叉树，中序[9,3,15,20,7],后序[9,15,7,20,3]


//: [Next](@next)
