module Generator.Hidato
    ( 
        Hidato,
        searchHamiltonianPath
    ) where

import Generator.Direction (Direction(..), directionToCol, directionToRow)

data Hidato = Hidato { matrix :: [[Int]], mask :: [[Bool]], freeCells :: Int } deriving (Show, Eq)
data Tree = BinaryTree { value :: Int, left :: Tree, right :: Tree } | Leaf Int deriving (Show, Eq)


searchHamiltonianPath :: Hidato -> [(Int, Int)]
searchHamiltonianPath hidato = searchHamiltonianPath' (matrix hidato) (mask hidato) (freeCells hidato)


searchHamiltonianPath' :: [[Int]] -> [[Bool]] -> Int -> [(Int, Int)]
searchHamiltonianPath' matrix mask freeCells = searchHamiltonianPath'' matrix mask freeCells (10,10) 0 0 Up [] 0 


searchHamiltonianPath'' :: [[Int]] -> [[Bool]] -> Int -> (Int,Int) -> Int -> Int -> Direction -> [(Int, Int)] -> Int -> [(Int, Int)]
searchHamiltonianPath'' matrix mask freeCells (amountRows, amountCols) row col direction path sizePath
    | isValidPosition' && freeCells == 1 = newPath 
    | isValidPosition' && newHamiltonianPath /= [] = newHamiltonianPath 
    | isValidPosition' && direction /= UpperLeftDiagonal = 
        searchHamiltonianPath'' matrix mask freeCells (amountRows, amountCols) row col (succ direction) path sizePath
    | otherwise = []
    where 
        newHamiltonianPath = searchHamiltonianPath'' newMatrix mask (freeCells - 1) (amountRows, amountCols) newRow newCol Up newPath newSizePath
        isValidPosition' = isValidPosition matrix mask (amountRows, amountCols) row col
        newRow = row + directionToRow direction
        newCol = col + directionToCol direction
        newPath = (row, col) : path
        newMatrix = replaceMatrix matrix row col newSizePath
        newSizePath = sizePath + 1


isValidPosition :: [[Int]] -> [[Bool]] -> (Int, Int) -> Int -> Int -> Bool
isValidPosition matrix mask (amountRows, amountCols) row col = 
    row < amountRows && col < amountCols
    && row >= 0 && col >= 0 
    && matrix !! row !! col == 0
    && mask !! row !! col


replace :: [a] -> Int -> a -> [a]
replace (x:xs) 0 value = value:xs
replace (x:xs) index value | index > 0 = x : replace xs (index - 1) value 


replaceMatrix :: [[a]] -> Int -> Int -> a -> [[a]]
replaceMatrix matrix row col value = 
    let newRow = replace (matrix !! row) col value 
    in replace matrix row newRow

