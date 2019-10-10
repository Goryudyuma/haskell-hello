{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString.Lazy (fromStrict)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Types (notFound404, ok200)
import Network.Wai (Application, pathInfo, responseLBS)
import Network.Wai.Handler.Warp (run)

app :: Application
app request respond =
  case pathInfo request of
    [] -> appRoot request respond
    ["hello"] -> appHello request respond
    ["hello", name] -> appHelloName name request respond
    _ -> appNotFound request respond

appRoot :: Application
appRoot _ respond =
  respond $ responseLBS ok200 [("Content-Type", "text/plain")] "Hello, Web!"

appHello :: Application
appHello _ respond =
  respond $ responseLBS ok200 [("Content-Type", "text/plain")] "Hello!"

appHelloName :: Text -> Application
appHelloName name _ respond =
  respond $
  responseLBS
    ok200
    [("Content-Type", "text/plain")]
    ("Hello, " <> (fromStrict $ encodeUtf8 name) <> "!")

appNotFound :: Application
appNotFound _ respond =
  respond $ responseLBS notFound404 [("Content-Type", "text/plain")] "NotFound"

main :: IO ()
main = run 8080 app
