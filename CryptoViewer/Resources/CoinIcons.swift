//
//  CoinIcons.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import Foundation

enum CoinIcons: String {
    case btc = "BTC"
    case eth = "ETH"
    case bnb = "BNB"
    case usdt = "USDT"
    case sol = "SOL"
    case ada = "ADA"
    case dot = "DOT"
    case hex = "HEX"
    case xrp = "XRP"
    case luna = "LUNA"
    case shib = "SHIB"
    case doge = "DOGE"
    case usdc = "USDC"
    case uni = "UNI"
    case avax = "AVAX"
    case link = "LINK"
    case wbtc = "WBTC"
    case ltc = "LTC"
    case busd = "BUSD"
    case matic = "MATIC"
    case bch = "BCH"
    case algo = "ALGO"
    case atom = "ATOM"
    case vet = "VET"
    case axs = "AXS"
    case icp = "ICP"
    case xlm = "XLM"
    case dai = "DAI"
    case theta = "THETA"
    case ceth = "CETH"
    case ftt = "FTT"
    case cake = "CAKE"
    case trx = "TRX"
    case etc = "ETC"
    case mana = "MANA"
    case oneInch = "1INCH"
    case okb = "OKB"
    case fil = "FIL"
    case xtz = "XTZ"
    case cro = "CRO"
    case xmr = "XMR"
    case egld = "EGLD"
    case eos = "EOS"
    case safeMoon = "SAFEMOON"
    case klay = "KLAY"
    case hbar = "HBAR"
    case rune = "RUNE"
    case aave = "AAVE"
    case amp = "AMP"
    case cdai = "CDAI"
    case ksm = "KSM"

    static func getImageName(for symbol: String) -> String {
        guard let icon = CoinIcons(rawValue: symbol) else { return "" }
        return icon.imageName
    }

    private var imageName: String {
        switch self {
        case .btc:
            return "bitcoin_btc"
        case .eth:
            return "eth"
        case .bnb:
            return "bnb"
        case .usdt:
            return "usdt"
        case .sol:
            return "solana"
        case .ada:
            return "ada"
        case .dot:
            return "polkadot"
        case .hex:
            return "hex-vector"
        case .xrp:
            return "xrp"
        case .luna:
            return "LUNA"
        case .shib:
            return "shib"
        case .doge:
            return "doge"
        case .usdc:
            return "usdc"
        case .uni:
            return "uniswap-v2"
        case .avax:
            return "avax-avalanche"
        case .link:
            return "chainlink"
        case .wbtc:
            return "wbtc"
        case .ltc:
            return "ltcnew"
        case .busd:
            return "busd"
        case .matic:
            return "polygon-matic-rebrand"
        case .bch:
            return "bch"
        case .algo:
            return "algo"
        case .atom:
            return "atom"
        case .vet:
            return "VEN"
        case .axs:
            return "axie-infinity"
        case .icp:
            return "dfinity-icp"
        case .xlm:
            return "Stellar_symbol_black_RGB"
        case .dai:
            return "mutli-collateral-dai"
        case .theta:
            return "theta"
        case .ceth:
            return "CETH2"
        case .ftt:
            return "ftx-exchange"
        case .cake:
            return "pancakeswap-cake-logo"
        case .trx:
            return "trx"
        case .etc:
            return "etc"
        case .mana:
            return "decentraland"
        case .oneInch:
            return "1inch_token"
        case .okb:
            return "Okex"
        case .fil:
            return "FIL3-filecoin"
        case .xtz:
            return "xtz"
        case .cro:
            return "cro"
        case .xmr:
            return "xmr"
        case .egld:
            return "Elrond"
        case .eos:
            return "eos2"
        case .safeMoon:
            return "safemoon"
        case .klay:
            return "klay"
        case .hbar:
            return "hedera"
        case .rune:
            return "ThorChain"
        case .aave:
            return "AAVE"
        case .amp:
            return "AMP-AMP"
        case .cdai:
            return "cDAI"
        case .ksm:
            return "kusama"
        }
    }
}
