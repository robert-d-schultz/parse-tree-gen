module MakeXBarXP where

import           Control.Monad
import           Data.Random.Extras hiding (shuffle)
import           Data.RVar
import           LoadData
import           MakeX
import           Prelude
import           XBarType

--Make X'

--NounBar main
makeNounBar :: InputData -> (Int,Int,Int,Int) -> RVar NounBar
makeNounBar idata limits = join $ choice pickfrom where
  foop ppl | ppl > 0 = [ makeNounBar2 idata (cpl, ppl-1, ajl, avl)
                      , makeNounBar31 idata (cpl, ppl-1, ajl, avl)
                      ]
           | otherwise = []
  fooj ajl | ajl > 0 = [ makeNounBar1 idata (cpl, ppl, ajl-1, avl)
                      ]
           | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = foop ppl ++ fooj ajl ++ [makeNounBar32 idata limits]

--AdjP + NounBar
makeNounBar1 :: InputData -> (Int,Int,Int,Int) -> RVar NounBar
makeNounBar1 idata limits =
  NounBar1 <$> (makeAdjP idata limits) <*> (makeNounBar idata limits)

--NounBar + PrepP
makeNounBar2 :: InputData -> (Int,Int,Int,Int) -> RVar NounBar
makeNounBar2 idata limits =
  NounBar2 <$> (makeNounBar idata limits) <*> (makePrepP idata limits)

--Noun with optional PrepP
makeNounBar31 :: InputData -> (Int,Int,Int,Int) -> RVar NounBar
makeNounBar31 idata limits =
  NounBar3 <$> (makeNoun idata) <*> (YesOpt <$> (makePrepP idata limits))

--Noun without optional PrepP
makeNounBar32 :: InputData -> (Int,Int,Int,Int) -> RVar NounBar
makeNounBar32 idata limits = do
  foo <- (makeNoun idata)
  return (NounBar3 foo (NoOpt))

--VerbBar main
makeVerbBar :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar idata limits = join $ choice pickfrom where
  fooc cpl | cpl > 0 = [ makeVerbBar4 idata (cpl-1, ppl, ajl, avl)
                ]
          | otherwise = []
  foop ppl | ppl > 0 = [ makeVerbBar2 idata (cpl, ppl-1, ajl, avl)
                ]
           | otherwise = []
  foov avl | avl > 0 = [ makeVerbBar1 idata (cpl, ppl, ajl, avl-1)
                , makeVerbBar3 idata (cpl, ppl, ajl, avl-1)
                ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = fooc cpl ++ foop ppl ++ foov avl ++ [makeVerbBar5 idata limits]

--AdvP + VerbBar
makeVerbBar1 :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar1 idata limits =
  VerbBar1 <$> (makeAdvP idata limits) <*> (makeVerbBar idata limits)

--VerbBar + PrepP
makeVerbBar2 :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar2 idata limits =
  VerbBar2 <$> (makeVerbBar idata limits) <*> (makePrepP idata limits)

--VerbBar + AdvP
makeVerbBar3 :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar3 idata limits =
  VerbBar3 <$> (makeVerbBar idata limits) <*> (makeAdvP idata limits)

--Verb + CompP
makeVerbBar4 :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar4 idata limits =
  VerbBar4 <$> (makeVerb idata) <*> (makeCompP idata limits)

--Verb + NounP
makeVerbBar5 :: InputData -> (Int,Int,Int,Int) -> RVar VerbBar
makeVerbBar5 idata limits =
  VerbBar5 <$> (makeVerb idata) <*> (makeDetP idata limits)

--AdjBar main
makeAdjBar :: InputData -> (Int,Int,Int,Int) -> RVar AdjBar
makeAdjBar idata limits = join $ choice pickfrom where
  foop ppl | ppl > 0 = [ makeAdjBar2 idata (cpl, ppl-1, ajl, avl)
                  , makeAdjBar31 idata (cpl, ppl-1, ajl, avl)
                  ]
          | otherwise = []
  fooj ajl | ajl > 0 = [ makeAdjBar1 idata (cpl, ppl, ajl-1, avl)
                  ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = foop ppl ++ fooj ajl ++ [makeAdjBar32 idata limits]

--AdjP + AdjBar
makeAdjBar1 :: InputData -> (Int,Int,Int,Int) -> RVar AdjBar
makeAdjBar1 idata limits =
  AdjBar1 <$> (makeAdjP idata limits) <*> (makeAdjBar idata limits)

--AdjBar PrepP
makeAdjBar2 :: InputData -> (Int,Int,Int,Int) -> RVar AdjBar
makeAdjBar2 idata limits =
  AdjBar2 <$> (makeAdjBar idata limits) <*> (makePrepP idata limits)

--Adj with the optional PrepP
makeAdjBar31 :: InputData -> (Int,Int,Int,Int) -> RVar AdjBar
makeAdjBar31 idata limits =
  AdjBar3 <$> (makeAdj idata) <*> (YesOpt <$> (makePrepP idata limits))

--Adj without the optional PrepP
makeAdjBar32 :: InputData -> (Int,Int,Int,Int) -> RVar AdjBar
makeAdjBar32 idata limits = do
  foo <- (makeAdj idata)
  return (AdjBar3 foo (NoOpt))

--AdvBar
makeAdvBar :: InputData -> (Int,Int,Int,Int) -> RVar AdvBar
makeAdvBar idata limits =
  AdvBar <$> (makeAdv idata)

--PrepBar main
makePrepBar :: InputData -> (Int,Int,Int,Int) -> RVar PrepBar
makePrepBar idata limits = join $ choice pickfrom where
  foop ppl | ppl > 0 = [ makePrepBar1 idata (cpl, ppl-1, ajl, avl)
                      ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = foop ppl ++ [makePrepBar2 idata limits]

--PrepBar + with the optional PrepP
makePrepBar1 :: InputData -> (Int,Int,Int,Int) -> RVar PrepBar
makePrepBar1 idata limits =
  PrepBar1 <$> (makePrepBar idata limits) <*> (makePrepP idata limits)

--Prep + DetP
makePrepBar2 :: InputData -> (Int,Int,Int,Int) -> RVar PrepBar
makePrepBar2 idata limits =
  PrepBar2 <$> (makePrep idata) <*> (makeDetP idata limits)

--DetBar main
makeDetBar :: InputData -> (Int,Int,Int,Int) -> RVar DetBar
makeDetBar idata limits =
--  join $ choice [makeDetBar1 idata limits, makeDetBar2 idata limits]
  join $ choice [makeDetBar1 idata limits]

--with optional determiner
makeDetBar1 :: InputData -> (Int,Int,Int,Int) -> RVar DetBar
makeDetBar1 idata limits =
  DetBar1 <$> (YesOpt <$> (makeDet idata)) <*> (makeNounP idata limits)

--without optional determiner
makeDetBar2 :: InputData -> (Int,Int,Int,Int) -> RVar DetBar
makeDetBar2 idata limits =
  DetBar1 (NoOpt) <$> (makeNounP idata limits)

--CompBar
makeCompBar :: InputData -> (Int,Int,Int,Int) -> RVar CompBar
makeCompBar idata limits =
  CompBar <$> (makeComp idata) <*> (makeTenseP idata limits)

--TenseBar
makeTenseBar :: InputData -> (Int,Int,Int,Int) -> RVar TenseBar
makeTenseBar idata limits =
  TenseBar <$> (makeTense idata) <*> (makeVerbP idata limits)

--ConjBar
makeConjBar :: InputData -> (Int,Int,Int,Int) -> RVar ConjBar
makeConjBar idata limits =
  ConjBar <$> (makeConj idata) <*> (makeDetP idata limits)

--NegBar
makeNegBar :: InputData -> (Int,Int,Int,Int) -> RVar NegBar
makeNegBar idata limits =
  NegBar <$> (makeNeg idata)


----------------------------Make XP---------------------------------------
--NounP
makeNounP :: InputData -> (Int,Int,Int,Int) -> RVar NounP
makeNounP idata limits =
  NounP <$> (makeNounBar idata limits)

--VerbP
makeVerbP :: InputData -> (Int,Int,Int,Int) -> RVar VerbP
makeVerbP idata limits =
  join $ choice [makeVerbP1 idata limits, makeVerbP2 idata limits]

--VerbP with negation phrase
makeVerbP1 :: InputData -> (Int,Int,Int,Int) -> RVar VerbP
makeVerbP1 idata limits =
  VerbP <$> (YesOpt <$> (makeNegP idata limits)) <*> (makeVerbBar idata limits)

--VerbP without negation phrase
makeVerbP2 :: InputData -> (Int,Int,Int,Int) -> RVar VerbP
makeVerbP2 idata limits =
  VerbP (NoOpt) <$> (makeVerbBar idata limits)

--AdjP
makeAdjP :: InputData -> (Int,Int,Int,Int) -> RVar AdjP
makeAdjP idata limits = join $ choice pickfrom where
  foov avl | avl > 0 = [ makeAdjP1 idata (cpl, ppl, ajl, avl-1)
                       ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = foov avl ++ [makeAdjP2 idata limits]

makeAdjP1 :: InputData -> (Int,Int,Int,Int) -> RVar AdjP
makeAdjP1 idata limits =
  AdjP <$> (YesOpt <$> (makeAdvP idata limits)) <*> (makeAdjBar idata limits)

makeAdjP2 :: InputData -> (Int,Int,Int,Int) -> RVar AdjP
makeAdjP2 idata limits =
  AdjP (NoOpt) <$> (makeAdjBar idata limits)

--AdvP main
makeAdvP :: InputData -> (Int,Int,Int,Int) -> RVar AdvP
makeAdvP idata limits = join $ choice pickfrom where
  foov avl | avl > 0 = [ makeAdvP1 idata (cpl, ppl, ajl, avl-1)
              ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = foov avl ++ [makeAdvP2 idata limits]

--AdvBar with optional AdvP
makeAdvP1 :: InputData -> (Int,Int,Int,Int) -> RVar AdvP
makeAdvP1 idata limits =
  AdvP <$> (YesOpt <$> (makeAdvP idata limits)) <*> (makeAdvBar idata limits)

--AdvBar without optional AdvP
makeAdvP2 :: InputData -> (Int,Int,Int,Int) -> RVar AdvP
makeAdvP2 idata limits =
  (AdvP NoOpt) <$> (makeAdvBar idata limits)

--PrepP main
makePrepP :: InputData -> (Int,Int,Int,Int) -> RVar PrepP
makePrepP idata limits = join $ choice pickfrom where
  fooj avl | avl > 0 = [ makePrepP1 idata (cpl, ppl, ajl, avl-1)
                      ]
          | otherwise = []
  (cpl, ppl, ajl, avl) = limits
  pickfrom = fooj ajl ++ [makePrepP2 idata limits]

--with optional AdjP
makePrepP1 :: InputData -> (Int,Int,Int,Int) -> RVar PrepP
makePrepP1 idata limits =
  PrepP <$> (YesOpt <$> (makeAdvP idata limits)) <*> (makePrepBar idata limits)

--without optional AdjP
makePrepP2 :: InputData -> (Int,Int,Int,Int) -> RVar PrepP
makePrepP2 idata limits =
  PrepP (NoOpt) <$> (makePrepBar idata limits)

--DetP
makeDetP :: InputData -> (Int,Int,Int,Int) -> RVar DetP
makeDetP idata limits =
  DetP <$> (makeDetBar idata limits)

--CompP
makeCompP :: InputData -> (Int,Int,Int,Int) -> RVar CompP
makeCompP idata limits =
  CompP <$> (makeCompBar idata limits)

--TenseP main
makeTenseP :: InputData -> (Int,Int,Int,Int) -> RVar TenseP
makeTenseP idata limits =
  join $ choice [makeTenseP1 idata limits, makeTenseP2 idata limits]

makeTenseP1 :: InputData -> (Int,Int,Int,Int) -> RVar TenseP
makeTenseP1 idata limits =
  TenseP1 <$> (makeDetP idata limits) <*> (makeTenseBar idata limits)

makeTenseP2 :: InputData -> (Int,Int,Int,Int) -> RVar TenseP
makeTenseP2 idata limits =
  TenseP2 <$> (makeConjP idata limits) <*> (makeTenseBar idata limits)

--ConjP
makeConjP :: InputData -> (Int,Int,Int,Int) -> RVar ConjP
makeConjP idata limits =
  ConjP <$> (makeDetP idata limits) <*> (makeConjBar idata limits)

--NegP
makeNegP :: InputData -> (Int,Int,Int,Int) -> RVar NegP
makeNegP idata limits =
  NegP <$> (makeNegBar idata limits)
