module test_exercise::nbtc;

use sui::event;

// Event structs matching nBTC events

public struct MintEvent has copy, drop {
    // Sui recipient
    recipient: address,
    fee: u64,
    dwallet_id: ID,
    utxo_id: u64,
    // btc data
    btc_script_publickey: vector<u8>,
    btc_tx_id: vector<u8>,
    btc_vout: u32,
    btc_amount: u64, // in satoshi
}

public struct RedeemRequestEvent has copy, drop {
    redeem_id: u64,
    redeemer: address,
    recipient_script: vector<u8>, // Full Bitcoin pubkey/lockscript
    amount: u64, // in satoshi
    created_at: u64,
}

public struct ProposeUtxoEvent has copy, drop {
    redeem_id: u64,
    dwallet_ids: vector<ID>,
    utxo_ids: vector<u64>,
}

const DUMMY_FEE: u64 = 1000;
const DUMMY_BTC_AMOUNT: u64 = 100000000; // 1 BTC in satoshi
const DUMMY_REDEEM_AMOUNT: u64 = 50000000; // 0.5 BTC in satoshi
const DUMMY_VOUT: u32 = 0;
const DUMMY_DWALLET_ADDR: address = @0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;
const DUMMY_DWALLET_1: address = @0xaaa1111111111111111111111111111111111111111111111111111111111111;
const DUMMY_DWALLET_2: address = @0xbbb2222222222222222222222222222222222222222222222222222222222222;
const DUMMY_UTXO_ID: u64 = 999;
const DUMMY_REDEEM_ID: u64 = 1;

public fun emit_mint_event(ctx: &mut TxContext) {

    let mint_event = MintEvent {
        recipient: tx_context::sender(ctx),
        fee: DUMMY_FEE,
        dwallet_id: object::id_from_address(DUMMY_DWALLET_ADDR),
        utxo_id: DUMMY_UTXO_ID,
        btc_script_publickey: b"dummy_script_publickey_data",
        btc_tx_id: b"dummy_bitcoin_transaction_id",
        btc_vout: DUMMY_VOUT,
        btc_amount: DUMMY_BTC_AMOUNT,
    };

    event::emit(mint_event);
}

public fun emit_redeem_request_event(ctx: &mut TxContext) {
    let redeem_event = RedeemRequestEvent {
        redeem_id: DUMMY_REDEEM_ID,
        redeemer: tx_context::sender(ctx),
        recipient_script: b"dummy_recipient_lockscript",
        amount: DUMMY_REDEEM_AMOUNT,
        created_at: 1234567890,
    };

    event::emit(redeem_event);
}

public fun emit_propose_utxo_event(_ctx: &mut TxContext) {
    let mut dwallet_ids = vector::empty<ID>();
    let mut utxo_ids = vector::empty<u64>();

    vector::push_back(&mut dwallet_ids, object::id_from_address(DUMMY_DWALLET_1));
    vector::push_back(&mut dwallet_ids, object::id_from_address(DUMMY_DWALLET_2));

    vector::push_back(&mut utxo_ids, DUMMY_UTXO_ID);
    vector::push_back(&mut utxo_ids, DUMMY_UTXO_ID + 1);

    let propose_event = ProposeUtxoEvent {
        redeem_id: DUMMY_REDEEM_ID,
        dwallet_ids,
        utxo_ids,
    };

    event::emit(propose_event);
}
