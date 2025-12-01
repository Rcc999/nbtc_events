#[test_only]
module test_exercise::test_exercise_tests;

use test_exercise::nbtc;
use sui::test_scenario;

const SENDER: address = @0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;

#[test]
fun test_emit_mint_event() {
    let mut scenario = test_scenario::begin(SENDER);

    nbtc::emit_mint_event(scenario.ctx());
    let effects = scenario.next_tx(SENDER);
    let events = test_scenario::num_user_events(&effects);
    assert!(events == 1, 0); 

    scenario.end();
}

#[test]
fun test_emit_redeem_request_event() {
    let mut scenario = test_scenario::begin(SENDER);

    nbtc::emit_redeem_request_event(scenario.ctx());

    let effects = scenario.next_tx(SENDER);
    let events = test_scenario::num_user_events(&effects);
    assert!(events == 1, 0); 

    scenario.end();
}

#[test]
fun test_emit_propose_utxo_event() {
    let mut scenario = test_scenario::begin(SENDER);

    nbtc::emit_propose_utxo_event(scenario.ctx());

    let effects = scenario.next_tx(SENDER);
    let events = test_scenario::num_user_events(&effects);
    assert!(events == 1, 0); 

    scenario.end();
}

#[test]
fun test_all_events_sequential() {
    let mut scenario = test_scenario::begin(SENDER);

    nbtc::emit_mint_event(scenario.ctx());
    let effects = scenario.next_tx(SENDER);
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    nbtc::emit_redeem_request_event(scenario.ctx());
    let effects = scenario.next_tx(SENDER);
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    nbtc::emit_propose_utxo_event(scenario.ctx());
    let effects = scenario.next_tx(SENDER);
    assert!(test_scenario::num_user_events(&effects) == 1, 0);

    scenario.end();
}
