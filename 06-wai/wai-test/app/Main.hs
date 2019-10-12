{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (join)
import Data.ByteString.Lazy (fromStrict)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Types
  ( methodDelete
  , methodGet
  , methodNotAllowed405
  , notFound404
  , ok200
  )
import Network.Wai
  ( Application
  , pathInfo
  , queryString
  , requestMethod
  , responseLBS
  )
import Network.Wai.Handler.Warp (run)

app :: Application
app request respond =
  let method = requestMethod request
   in respond $
      if method == methodGet
        then responseLBS ok200 [("Content-Type", "text/plain")] $ "Hello!"
        else if method == methodDelete
               then responseLBS ok200 [("Content-Type", "text/plain")] $ "Bye!"
               else responseLBS
                      methodNotAllowed405
                      [("Content-Type", "text/plain")] $
                    "Method Not Aloowed"

main :: IO ()
main = run 8080 app
