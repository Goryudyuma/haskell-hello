{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (join)
import Data.ByteString.Lazy (fromStrict)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Types (notFound404, ok200)
import Network.Wai (Application, pathInfo, queryString, responseLBS)
import Network.Wai.Handler.Warp (run)

app :: Application
app request respond =
  let mname = join $lookup "name" $ queryString request
   in respond $
      responseLBS ok200 [("Content-Type", "text/plain")] $
      case mname of
        Just name -> "Hello, " <> (fromStrict name) <> "!"
        Nothing -> "Hello!"

main :: IO ()
main = run 8080 app
