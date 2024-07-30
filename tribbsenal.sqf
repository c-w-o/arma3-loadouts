/*
 * Author: Don
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Items <BOOL> <ARRAY>
 * 2: Initialize globally <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_box, ["MyItem1", "MyItem2", "MyItemN"]] call ace_arsenal_fnc_initBox
 * [this] call compile "donsenal/donsenal.sqf"
 *
 * Public: Yes
*/
#include "donsenal_func.sqf"
params [["_object", objNull, [objNull]]];

private _loadout_folder="loadouts";

/* Ab hier wird das eigentliche Klassenmenü aufgebaut.

*/

private _unit_classes=createHashMapFromArray [
  [ "Normal",                   [1,           createHashMapFromArray [      
    ["Funker",                    [1,           "Funker.sqf"]],
    ["Grenadier",                 [1,           "grenadier.sqf"]],
    ["Gruppenführer",             [1,           createHashMapFromArray [
      [ "G38",                      [1,           "Gruppenfuehrer.sqf"]],
      [ "G38 + Langstreckenfunk",   [1,           "Gruppenfuehrer_LSFunk.sqf"]],
      [ "G27",                      [1,           "Gruppenfuehrer_G27.sqf"]],
      [ "G27 + Langstreckenfunk",   [1,           "Gruppenfuehrer_G27_LSFunk.sqf"]]
    ]]],
    ["AT Leuchtbüchse HEAT-T",    [1,           "AT_Leuchtbuechse_HEAT-T.sqf"]],
    ["AT Panzerfaust 3",          [1,           "AT_PZ3.sqf"]],
    ["MG",                        [1,           "MG.sqf"]],
    ["Munitionsträger LB HEAT-T", [1,           "Munitionstraeger_LB_HEAT-T.sqf"]],
    ["Pionier",                   [1,           "Pionier.sqf"]],
    ["Sanitäter",                 [1,           "Sanitaeter.sqf"]],
    ["Scharfschütze",             [1,           createHashMapFromArray [
      [ "G28",                      [1,           "Scharfschuetze1.sqf"]],
      [ "G29",                      [1,           "Scharfschuetze2.sqf"]],
      [ "G82",                      [1,           "Scharfschuetze3.sqf"]]
    ]]],
    ["Schütze G27",               [1,           "Schuetze_G27.sqf"]],
    ["Schütze",                   [1,           "Schuetze.sqf"]],
    ["Späher",                    [1,           "Spaeher.sqf"]],
    ["Truppführer",               [1,           createHashMapFromArray [
      [ "Rucksack",                 [1,           "Truppfuehrer.sqf"]],
      [ "Langstreckenfunk",         [1,           "Truppfuehrer_LSFunk.sqf"]]
    ]]],
    ["UAV Operator",              [1,           createHashMapFromArray [
      [ "Leicht",                   [1, "UAV_Operator_Leicht.sqf"]],
      [ "Schwer",                   [1, "UAV_Operator_Schwer.sqf"]]
    ]]]
  ]]],
  [ "Spezial",                  [0,           createHashMapFromArray [    
    ["Funker",                    [1,           "Funker_Spezial.sqf"]],
    ["Grenadier",                 [1,           "grenadier_Spezial.sqf"]],
    ["Gruppenführer",             [1,           createHashMapFromArray [
      [ "G38",                      [1,           "Gruppenfuehrer_Spezial.sqf"]],
      [ "G38 + Langstreckenfunk",   [1,           "Gruppenfuehrer_LSFunk_Spezial.sqf"]],
      [ "G27",                      [1,           "Gruppenfuehrer_G27_Spezial.sqf"]],
      [ "G27 + Langstreckenfunk",   [1,           "Gruppenfuehrer_G27_LSFunk_Spezial.sqf"]]
      
    ]]],
    ["AT Leuchtbüchse",           [1,             "AT_Leuchtbuechse_HEAT-T_Spezial.sqf"]],
    ["AT Panzerfaust 3",          [1,             "AT_PZ3_Spezial.sqf"]],
    ["MG",                        [1,             "MG_Spezial.sqf"]],
    ["Munitionsträger LB HEAT-T", [1,             "Munitionstraeger_LB_HEAT-T_Spezial.sqf"]],
    ["Pionier",                   [1,             "Pionier_Spezial.sqf"]],
    ["Sanitäter",                 [1,             "Sanitaeter_Spezial.sqf"]],
    ["Scharfschütze",             [1,             createHashMapFromArray [
      [ "G28",                      [1,             "Scharfschuetze1_Spezial.sqf"]],
      [ "G29",                      [1,             "Scharfschuetze2_Spezial.sqf"]],
      [ "G82",                      [1,             "Scharfschuetze3_Spezial.sqf"]]
    ]]],
    ["Schütze G27",               [1,             "Schuetze_G27_Spezial.sqf"]],
    ["Schütze",                   [1,             "Schuetze_Spezial.sqf"]],
    ["Späher",                    [1,             "Spaeher_Spezial.sqf"]],
    ["Truppführer",               [1,             createHashMapFromArray [
      [ "Rucksack",                 [1,             "Truppfuehrer_Spezial.sqf"]],
      [ "Langstreckenfunk",         [1,             "Truppfuehrer_LSFunk_Spezial.sqf"]]
    ]]],
    ["UAV Operator",              [1,             createHashMapFromArray [
      [ "Leicht",                   [1,             "UAV_Operator_Leicht_Spezial.sqf"]],
      [ "Schwer",                   [1,             "UAV_Operator_Schwer_Spezial.sqf"]]
    ]]]
  ]]],
  [ "Sonderloadouts",           [1,           createHashMapFromArray [
    ["Aluhut",                    [0,           "ALUHUT.sqf"]],
    ["Leer",                      [1,           "Leer.sqf"]],
    ["Voll",                      [0,           "Voll.sqf"]],
    ["NATO Kampfpilot",           [1,           "NATO_Kampfpilot.sqf"]],
    ["Panzerbesatzung",           [1,           "Panzerbesatzung.sqf"]]  
  ]]]

];


[_object, true] call ace_arsenal_fnc_initBox;

[ _object, _unit_classes, _loadout_folder ] call fcn_loadout_menu;
