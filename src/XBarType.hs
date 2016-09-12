module XBarType
( Optional(..)
, NounP(..)
, NounBar(..)
, Noun(..)
, VerbP(..)
, VerbBar(..)
, Verb(..)
, AdjP(..)
, AdjBar(..)
, Adj(..)
, AdvP(..)
, AdvBar(..)
, Adv(..)
, PrepP(..)
, PrepBar(..)
, Prep(..)
, DetP(..)
, DetBar(..)
, Det(..)
, CompP(..)
, CompBar(..)
, Comp(..)
, TenseP(..)
, TenseBar(..)
, Tense(..)
, ConjP(..)
, ConjBar(..)
, Conj(..)
, AgrSP(..)
, AgrSBar(..)
, AgrS(..)
, AgrOP(..)
, AgrOBar(..)
, AgrO(..)
) where

-- X-bar theory data

--data Reverse a b = XbarFirst a b | XbarSecond b a

data Optional a = YesOpt a | NoOpt  deriving (Show, Read)

--Noun phrase
data NounP = NounP NounBar deriving (Show, Read)
data NounBar = NounBar1 AdjP NounBar | NounBar2 NounBar PrepP | NounBar3 Noun (Optional PrepP) deriving (Show, Read)
data Noun = Noun String deriving (Show, Read)

--Verb phrase
data VerbP = VerbP VerbBar deriving (Show, Read)
data VerbBar = VerbBar1 AdvP VerbBar | VerbBar2 VerbBar PrepP | VerbBar3 VerbBar AdvP | VerbBar4 Verb CompP | VerbBar5 Verb DetP deriving (Show, Read)
data Verb = Verb String deriving (Show, Read)

--Adjective phrase
data AdjP = AdjP AdjBar deriving (Show, Read)
data AdjBar = AdjBar1 AdvP AdjBar | AdjBar2 AdjP AdjBar | AdjBar3 AdjBar (Optional PrepP) | AdjBar4 Adj (Optional PrepP) deriving (Show, Read)
data Adj = Adj String deriving (Show, Read)

--Adverb phrase
data AdvP = AdvP (Optional AdvP) AdvBar deriving (Show, Read)
data AdvBar = AdvBar Adv deriving (Show, Read)
data Adv = Adv String deriving (Show, Read)

--Prepositional phrase
data PrepP = PrepP (Optional AdjP) PrepBar deriving (Show, Read)
data PrepBar = PrepBar1 PrepBar (Optional PrepP) | PrepBar2 Prep DetP deriving (Show, Read)
data Prep = Prep String deriving (Show, Read)

--Determiner phrase
data DetP = DetP DetBar deriving (Show, Read)
data DetBar = DetBar1 (Optional Det) NounP | DetBar2 Pron deriving (Show, Read)
data Det = Det String deriving (Show, Read)

--Complementizer phrase
data CompP = CompP CompBar deriving (Show, Read)
data CompBar = CompBar Comp TenseP deriving (Show, Read)
data Comp = Comp String deriving (Show, Read)

--Tense phrase
data TenseP = TenseP1 DetP TenseBar | TenseP2 ConjP TenseBar deriving (Show, Read)
data TenseBar = TenseBar Tense AgrSP deriving (Show, Read)
data Tense = Tense String deriving (Show, Read)

--Conjunction phrase
data ConjP = ConjP DetP ConjBar deriving (Show, Read)
data ConjBar = ConjBar Conj DetP deriving (Show, Read)
data Conj = Conj String deriving (Show, Read)

--Subject agreement phrase
data AgrSP = AgrSP AgrSBar deriving (Show, Read)
data AgrSBar = AgrSBar AgrS VerbP deriving (Show, Read)
data AgrS = AgrS String deriving (Show, Read)

--Object agreement phrase
data AgrOP = AgrOP AgrOBar deriving (Show, Read)
data AgrOBar = AgrOBar AgrO TenseP deriving (Show, Read)
data AgrO = AgrO String deriving (Show, Read)

--Negation phrase
data NegP = NegP NegBar deriving (Show, Read)
data NegBar = NegBar Neg deriving (Show, Read)
data Neg = Neg String deriving (Show, Read)

--Aspect phrase
data AspP = AspP AspBar deriving (Show, Read)
data AspBar = AspBar Asp deriving (Show, Read)
data Asp = Asp String deriving (Show, Read)

--Number phrase
data NumbP = NumbP NumbBar deriving (Show, Read)
data NumbBar = NumbBar Numb deriving (Show, Read)
data Numb = Numb String deriving (Show, Read)

--"little vP" - for ditransitive verbs
data LilVerbP = LilVerbP LilVerbBar deriving (Show, Read)
data LilVerbBar = LilVerbBar LilVerb deriving (Show, Read)
data LilVerb = LilVerb String deriving (Show, Read)

--Pronoun
data Pron = Pron String deriving (Show, Read)
