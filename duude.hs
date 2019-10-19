import qualified System.Random
import Control.Exception (assert)

-- We represent the 'looks' by an array of integers, where a value of x at position i means that
-- person i has looked at the person at position x.
type People = [Int]
type Looks = [Int]

main :: IO ()
main = do
  let n = 100
  let numberOfTrials = 5000

  outcomes <- sequence $ replicate numberOfTrials (runTrial n)

  putStrLn $ "Number of trials: " ++ (show numberOfTrials)
  let average = (realToFrac $ sum outcomes) / (realToFrac numberOfTrials)
  putStrLn $ "Average: " ++ (show average)

runTrial :: Int -> IO Int
runTrial n = do
  let people = [0..(n-1)]

  looks <- generateLooks people
  let numberOfDuudePairs = length $ duudePairs people looks

  -- The number of instances of 'duude' is the number of pairs divided by 2. The number of pairs
  -- should always be even because of how it is constructed.
  return $ assert (even numberOfDuudePairs) $ numberOfDuudePairs `div` 2

generateLooks :: People -> IO Looks
generateLooks people =
  -- Each person makes a random choice from the list of all other people.
  sequence $ map (\x -> choice $ filter (x /=) people) people

-- Choose a random element from a list.
choice :: [a] -> IO a
choice list = do
  index <- System.Random.randomRIO (0, (length list) - 1)
  return (list !! index)

-- For a given set of looks, get all the people who are looking at each other.
duudePairs :: People -> Looks -> Looks
duudePairs people looks =
  filter (\x -> x == (looks !! (looks !! x))) people
