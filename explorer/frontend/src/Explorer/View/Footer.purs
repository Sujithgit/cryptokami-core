module Explorer.View.Footer (footerView) where

import Prelude

import Data.Foldable (for_)
import Data.Lens ((^.))
import Data.String (take)
import Explorer.I18n.Lang (Language, langCode, translate)
import Explorer.I18n.Lenses (footer, fooCryptokamiOpenSource, fooCryptokamiHub, fooCryptokamiSlack
  , fooDisclaimerPt1, fooDisclaimerPt2, fooCryptokamiFoundation, fooEmail, fooGithub, fooIohkSupportP, fooCryptokamiDocumentation
  , fooCryptokamiTestnet, fooCryptokamiSource, fooCryptokamiFoundationYoutube, fooCryptokamiFoundationTwitter
  , fooDaedalusPlatform, fooWhyCryptokami, fooCryptokamiRoadmap, fooCryptokamiReddit, fooCryptokamiCommunity
  , fooIOHK, fooIOHKBlog, fooIOHKYoutube, fooTwitter, fooProject, fooFoundation, fooLearnMore, fooProtocol) as I18nL
import Explorer.Lenses.State (lang)
import Explorer.Types.Actions (Action(..))
import Explorer.Types.State (State)
import Explorer.Util.Config (commitHash, version)
import Explorer.View.Common (langItems)
import Pux.DOM.Events (onClick) as P
import Pux.DOM.HTML (HTML) as P
import Text.Smolder.HTML (div, nav, a, li, p, span, ul) as S
import Text.Smolder.HTML.Attributes (className, href, title) as S
import Text.Smolder.Markup ((!), (#!))
import Text.Smolder.Markup (text) as S

footerView :: State -> P.HTML Action
footerView state =
    let lang' = state ^. lang in
    S.div ! S.className "explorer-footer" $ do
        S.div ! S.className "explorer-footer__top" $ do
            S.div ! S.className "explorer-footer__container" $ do
                S.div ! S.className "explorer-footer__top--content" $ do
                    S.div ! S.className "content__container content__container--left" $ do
                        langView
                        S.a ! S.className "nav__item--link link-open-source"
                            ! S.href "https://opensource.org/licenses/MIT"
                            $ S.text (translate (I18nL.footer <<< I18nL.fooCryptokamiOpenSource) lang')
                        S.p ! S.className "disclaimer"
                            $ S.text (translate (I18nL.footer <<< I18nL.fooDisclaimerPt1) lang')
                        S.p ! S.className "disclaimer"
                            $ S.text (translate (I18nL.footer <<< I18nL.fooDisclaimerPt2) lang')
                        navBottomListView $ navBottmItems lang'
                    S.div ! S.className "content__container content__container--right" $ do
                          socialListView $ socialItems lang'
                          S.nav ! S.className "nav__container" $ do
                              navListView $ navItemsLeft lang'
                              navListView $ navItemsRight lang'
        S.div ! S.className "explorer-footer__bottom" $ do
            S.div ! S.className "explorer-footer__container" $ do
                S.div ! S.className "logo__wrapper" $ do
                    S.div ! S.className "logo__container" $ do
                        S.a ! S.className "logo__cryptokami-name bg-logo-cryptokami-name"
                            ! S.href "//iohk.io/projects/cryptokami/"
                            $ S.text ""
                    S.span  ! S.className "split"
                            $ S.text ""
                    S.a ! S.className "support"
                        ! S.href "//iohk.io/projects/cryptokami/"
                        $ S.text (translate (I18nL.footer <<< I18nL.fooIohkSupportP) lang')
                    S.div ! S.className "logo__container"
                          $ S.a ! S.className "logo__iohk-name bg-iohk-logo"
                                ! S.href "//iohk.io/"
                                $ S.text ""
            S.div ! S.className "explorer-footer__container explorer-footer__meta" $ do
                S.span  ! S.className "version"
                        $ S.text ("v. " <> version)
                S.a ! S.className "commit"
                    ! S.href ("https://github.com/input-output-hk/cryptokami-sl/commit/" <> commitHash)
                    $ S.text $ "( " <> (take 7 $ commitHash) <> " )"

-- lang

-- TODO(jk) move lagn views into Common.purs

langView :: P.HTML Action
langView =
    S.ul  ! S.className "lang-nav__container"
          $ for_ langItems langItemView

langItemView :: Language -> P.HTML Action
langItemView lang' =
    let flagClazz = "bg-icon-lang-" <> langCode lang' in
    S.li ! S.className ("lang-nav__item " <> flagClazz )
        #! P.onClick (const $ SetLanguage lang')
        $ S.text (show lang')

-- social

type SocialItem =
    { link :: String
    , label :: String
    , iconClazz :: String
    }

socialItems :: Language -> Array SocialItem
socialItems lang =
    [ { label: translate (I18nL.footer <<< I18nL.fooTwitter) lang
      , link: "https://twitter.com/cryptokamistiftung"
      , iconClazz: "bg-icon-twitter"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooEmail) lang
      , link: "mailto:info@cryptokamihub.org"
      , iconClazz: "bg-icon-email"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooGithub) lang
      , link: "https://github.com/input-output-hk/cryptokami-sl/"
      , iconClazz: "bg-icon-github"
      }
    ]

socialListView :: Array SocialItem -> P.HTML Action
socialListView items =
    S.ul  ! S.className "social-nav__container"
          $ for_ items socialItemView

socialItemView :: SocialItem -> P.HTML Action
socialItemView item =
    S.li ! S.className "social-nav__item "
         $ S.a  ! S.className "social-nav__item--link"
                ! S.href item.link
                ! S.title item.label
                $ S.span  ! S.className ("icon "
                              <> item.iconClazz)
                          $ S.text ""

-- nav

type NavItem =
    { label :: String
    , link :: String
    }

navItemsLeft :: Language -> Array NavItem
navItemsLeft lang =
    [ { label: translate (I18nL.footer <<< I18nL.fooCryptokamiDocumentation) lang
      , link: "//cryptokamidocs.com"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiRoadmap) lang
      , link: "https://cryptokamiroadmap.com"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiTestnet) lang
      , link: "https://tada.iohk.io"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiSource) lang
      , link: "https://github.com/input-output-hk/cryptokami-sl"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiFoundation) lang
      , link: "https://cryptokamifoundation.org"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiHub) lang
      , link: "https://cryptokamihub.org"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooWhyCryptokami) lang
      , link: "https://whycryptokami.com"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiFoundationYoutube) lang
      , link: "https://www.youtube.com/channel/UCbQ9vGfezru1YRI1zDCtTGg"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiFoundationTwitter) lang
      , link: "https://twitter.com/CryptokamiStiftung"
      }
    ]

navItemsRight :: Language -> Array NavItem
navItemsRight lang =
    [ { label: translate (I18nL.footer <<< I18nL.fooCryptokamiSlack) lang
      , link: "https://cryptokami.herokuapp.com"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiReddit) lang
      , link: "https://www.reddit.com/r/cryptokami/"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooCryptokamiCommunity) lang
      , link: "https://cryptokamihub.org"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooDaedalusPlatform) lang
      , link: "https://daedaluswallet.io"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooIOHK) lang
      , link: "https://iohk.io"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooIOHKBlog) lang
      , link: "https://iohk.io/blog/"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooIOHKYoutube) lang
      , link: "https://www.youtube.com/channel/UCBJ0p9aCW-W82TwNM-z3V2w"
      }
    ]

navListView :: Array NavItem -> P.HTML Action
navListView items =
    S.ul  ! S.className "nav__list"
          $ for_ items navItemView

navItemView :: NavItem -> P.HTML Action
navItemView item =
    S.li ! S.className "nav__item"
         $ S.a  ! S.className "nav__item--link"
                ! S.href item.link
                $ S.text item.label

navBottmItems :: Language -> Array NavItem
navBottmItems lang =
    [ { label: translate (I18nL.footer <<< I18nL.fooProject) lang
      , link: "https://cryptokamifoundation.org/project/"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooProtocol) lang
      , link: "https://cryptokamifoundation.org/protocol/"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooFoundation) lang
      , link: "https://cryptokamifoundation.org/foundation/"
      }
    , { label: translate (I18nL.footer <<< I18nL.fooLearnMore) lang
      , link: "https://cryptokamifoundation.org/learn-more/"
      }
    ]

navBottomListView :: Array NavItem -> P.HTML Action
navBottomListView items =
    S.ul  ! S.className "nav-bottom__list"
          $ for_ items navBottomItemView

navBottomItemView :: NavItem -> P.HTML Action
navBottomItemView item =
    S.li ! S.className "nav-bottom__item"
         $ S.a  ! S.className "nav-bottom__item--link"
                ! S.href item.link
                $ S.text item.label
