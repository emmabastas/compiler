{-# LANGUAGE TemplateHaskell #-}
module Elm.BundeledKernel
  ( exists
  , load
  , moduleNames
  )
  where


import qualified Elm.ModuleName as ModuleName
import qualified Elm.Package as Pkg
import qualified Data.Name as Name
import qualified Data.ByteString as BS
import qualified Data.Map.Strict as Map
import System.FilePath ((<.>))
import qualified System.FilePath as FP
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


moduleNames :: [ModuleName.Canonical]
moduleNames =
  let
    repl '/' = '.'
    repl c = c
  in
  fmap
    (\(filePath, _) ->
      ModuleName.Canonical
        Pkg.kernel
        (Name.fromChars (map repl $ FP.dropExtension filePath))
    )
    (Map.toList modules)
