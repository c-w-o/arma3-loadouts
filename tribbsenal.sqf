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
  [ "Normal", createHashMapFromArray [      /* hier kommen alle "normalen" loadouts rein */
    ["Funker", "Funker.sqf"],
    ["Grenadier", "grenadier.sqf"],
    ["Gruppenführer", createHashMapFromArray [
      [ "G38", "Gruppenfuehrer.sqf"],
      [ "G38 + Langstreckenfunk", "Gruppenfuehrer_LSFunk.sqf"],
      [ "G27", "Gruppenfuehrer_G27.sqf"],
      [ "G27 + Langstreckenfunk", "Gruppenfuehrer_G27_LSFunk.sqf"]
    ]],
    ["AT Leuchtbüchse HEAT-T", "AT_Leuchtbuechse_HEAT-T.sqf"],
    ["AT Panzerfaust 3", "AT_PZ3.sqf"],
    ["MG", "MG.sqf"],
    ["Munitionsträger LB HEAT-T", "Munitionstraeger_LB_HEAT-T.sqf"],
    ["Pionier", "Pionier.sqf"],
    ["Sanitäter", "Sanitaeter.sqf"],
    ["Scharfschütze", createHashMapFromArray [
      [ "G28", "Scharfschuetze1.sqf"],
      [ "G29", "Scharfschuetze2.sqf"],
      [ "G82", "Scharfschuetze3.sqf"]
    ]],
    ["Schütze G27", "Schuetze_G27.sqf"],
    ["Schütze", "Schuetze.sqf"],
    ["Späher", "Spaeher.sqf"],
    ["Truppführer", createHashMapFromArray [
      [ "Rucksack", "Truppfuehrer.sqf"],
      [ "Langstreckenfunk", "Truppfuehrer_LSFunk.sqf"]
    ]],
    ["UAV Operator", createHashMapFromArray [
      [ "Leicht", "UAV_Operator_Leicht.sqf"],
      [ "Schwer", "UAV_Operator_Schwer.sqf"]
    ]]
  ]],
  [ "Spezial", createHashMapFromArray [     /* und hier die "speziellen" loadouts */
    ["Funker", "Funker_Spezial.sqf"],
    ["Grenadier", "grenadier_Spezial.sqf"],
    ["Gruppenführer", createHashMapFromArray [
      [ "G38", "Gruppenfuehrer_Spezial.sqf"],
      [ "G38 + Langstreckenfunk", "Gruppenfuehrer_LSFunk_Spezial.sqf"],
      [ "G27", "Gruppenfuehrer_G27_Spezial.sqf"],
      [ "G27 + Langstreckenfunk", "Gruppenfuehrer_G27_LSFunk_Spezial.sqf"]
      
    ]],
    ["AT Leuchtbüchse", "AT_Leuchtbuechse_HEAT-T_Spezial.sqf"],
    ["AT Panzerfaust 3", "AT_PZ3_Spezial.sqf"],
    ["MG", "MG_Spezial.sqf"],
    ["Munitionsträger LB HEAT-T", "Munitionstraeger_LB_HEAT-T_Spezial.sqf"],
    ["Pionier", "Pionier_Spezial.sqf"],
    ["Sanitäter", "Sanitaeter_Spezial.sqf"],
    ["Scharfschütze", createHashMapFromArray [
      [ "G28", "Scharfschuetze1_Spezial.sqf"],
      [ "G29", "Scharfschuetze2_Spezial.sqf"],
      [ "G82", "Scharfschuetze3_Spezial.sqf"]
    ]],
    ["Schütze G27", "Schuetze_G27_Spezial.sqf"],
    ["Schütze", "Schuetze_Spezial.sqf"],
    ["Späher", "Spaeher_Spezial.sqf"],
    ["Truppführer", createHashMapFromArray [
      [ "Rucksack", "Truppfuehrer_Spezial.sqf"],
      [ "Langstreckenfunk", "Truppfuehrer_LSFunk_Spezial.sqf"]
    ]],
    ["UAV Operator", createHashMapFromArray [
      [ "Leicht", "UAV_Operator_Leicht_Spezial.sqf"],
      [ "Schwer", "UAV_Operator_Schwer_Spezial.sqf"]
    ]]
  ]],
  [ "Sonderloadouts", createHashMapFromArray [
    ["Aluhut", "ALUHUT.sqf"],
    ["Leer", "Leer.sqf"],
    ["Voll", "Voll.sqf"],
    ["NATO Kampfpilot", "NATO_Kampfpilot.sqf"],
    ["Panzerbesatzung", "Panzerbesatzung.sqf"]  
  ]]

];

[_object, true] call ace_arsenal_fnc_initBox;

[ _object, _unit_classes, _loadout_folder ] call fcn_loadout_menu;
