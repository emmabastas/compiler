{-# LANGUAGE TemplateHaskell #-}
module Elm.BundeledKernel
  ( exists
  , load
  )
  where


import qualified Elm.ModuleName as ModuleName
import qualified Data.ByteString as BS
import qualified Data.Map.Strict as Map
import System.FilePath ((<.>))
import Data.FileEmbed


modules :: Map.Map FilePath BS.ByteString
modules = Map.fromList $ $(embedDir "compiler/src/Elm/BundeledKernel")


toFilePath :: ModuleName.Raw -> FilePath
toFilePath moduleName =
  ModuleName.toFilePath moduleName <.> "js"


exists :: ModuleName.Raw -> Bool
exists moduleName =
  Map.member (toFilePath moduleName) modules


load :: ModuleName.Raw -> Maybe BS.ByteString
load moduleName =
  Map.lookup (toFilePath moduleName) modules
