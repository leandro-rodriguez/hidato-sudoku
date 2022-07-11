module Main(main) where

import Solver.Main(solveTemplate)
import System.Directory



data Prompt = Prompt { addr :: FilePath }

-- instance Show Prompt where
--     show (Prompt addr) = "\n" ++ (show addr) ++ " $ "

main :: IO ()
main = do 
    
    rootPath <- getCurrentDirectory
    
    
    let prompt = Prompt { addr = rootPath }

    putStrLn "Enter the solve command and, after a blank space, the template name"


    command <- getLine
    if  equalCommand command "solve " 
        then do let template = getTemplate command "solve"
                solution <- solveTemplate template rootPath
                print solution
        else main

equalCommand :: String -> String -> Bool
equalCommand _ [] = True
equalCommand (x:xs) (y:ys) | x == y = equalCommand xs ys
                           | otherwise = False

getTemplate :: String -> String -> String
getTemplate (x:xs) [] = xs 
getTemplate (x:xs) (_:ys) = getTemplate xs ys


-- main = do
--         putStrLn "Welcome to Hidato!!! Type 'help' to see the list of available commands."
--         hFlush stdout
--         console


-- console :: IO ()
-- console = do
--         Console.start cmds

-- cmds :: [Command]
-- cmds = [commandGenerate, commandSolve]


-- generateFunction :: [Char] -> [Char] -> [Char] -> [Char] -> FilePath -> [Char] -> IO ()
-- generateFunction rs cs ra di path to = do
--         seed <- randomIO :: IO Int
--         let gen = mkStdGen seed
--         let seeds = randoms gen :: [Int]

--         let rows = read rs :: Int
--         let columns = read cs :: Int
--         let ratio = read ra :: Float
--         let tout = read to :: Int

--         (ok, m) <- generateGame rows columns ratio difficulty tout

--         if ok then do
--                 writeFile path (show m)
--                 print m
--         else do
--                 putStrLn "The generator could not generate a hidato with the indicated arguments and the indicated time." 


-- commandGenerate :: Command
-- commandGenerate =
--         Command
--         {
--                 cmdName = "generate",
--                 cmdDescription = "Command to generate a hidato. The board is save to a file.\nDifficulty: [Easy, Normal, Hard]\nDefault timeout: 60000000 microseconds = 1 minute",
--                 cmdArgs = ["ROWS", "COLUMNS", "RATIO", "DIFFICULTY", "FILEPATH", "TIMEOUT (OPTIONAL)"],
--                 cmdIO = \args -> do
--                         case args of
--                                 [rs, cs, ra, di, path] -> generateFunction rs cs ra di path "60000000"
--                                 [rs, cs, ra, di, path, to] -> generateFunction rs cs ra di path to
--                                 otherwise -> print "The number of arguments is not correct"
--                         return 0
--         }


-- commandSolve :: Command
-- commandSolve =
--         Command
--         {
--                 cmdName = "solve",
--                 cmdDescription = "Command to solve a hidato. The board is obtained from a file.",
--                 cmdArgs = ["FILEPATH"],
--                 cmdIO = \args -> do
--                         case args of
--                                 [filePath] -> do
--                                         solve <- solveTemplate template rootPath
--                                         print solve
--                                         -- let table = read text :: Matrix
--                                         -- seed <- randomIO :: IO Int
--                                         -- let gen = mkStdGen seed
--                                         -- let seeds = randoms gen :: [Int]
--                                         -- let solves = solveAll table seeds
--                                         -- if null solves then do
--                                         --         print "Solve not found"
--                                         -- else do
--                                         --         print $ head solves
--                                 otherwise -> print "The number of arguments is not correct"
--                         return 0
--         }
