module Test.Pos.Launcher.ConfigurationSpec
    ( spec
    ) where

import           Universum

import           System.Wlog (LoggerName (..))
import           Test.Hspec (Spec, describe, it, shouldSatisfy)

import           Pos.Launcher.Configuration (ConfigurationOptions (..),
                     defaultConfigurationOptions, withConfigurationsM)
import           Pos.Util.Config (ConfigurationException)

spec :: Spec
spec = describe "Pos.Launcher.Configuration" $ do
    describe "withConfigurationsM" $ do
        it "should parse `lib/configuration.yaml` file" $ do
            let catchFn :: ConfigurationException -> IO (Maybe ConfigurationException)
                catchFn e = return $ Just e
            let cfo = defaultConfigurationOptions
                        { cfoFilePath = "./configuration.yaml" }
            res  <- liftIO $ catch
                (withConfigurationsM (LoggerName "test") Nothing cfo (\_ _ -> return Nothing))
                catchFn
            res `shouldSatisfy` isNothing

