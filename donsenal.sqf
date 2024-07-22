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

params [["_object", objNull, [objNull]]];

/* Variante 1 - keine Camos, keine Spezialvarianten
	createHashMapFromArray [
		["type", "weapon_name"],
		["attachments", ["attach_type"]],
		["ammo", [[1,"clip_type"]]]
	];

*//* Variante 2: keine Camos, aber Spezialvarianten
	createHashMapFromArray [
		["special",     createHashMapFromArray [
			["type", "weapon_name"],
			["attachments", ["attach_type"]],
			["ammo", [[1,"clip_type"]]]
			]
		],
		["regular",     createHashMapFromArray [
			["type", "weapon_name"],
			["attachments", ["attach_type"]],
			["ammo", [[1,"clip_type"]]]
			]
		]
	];
*//* Variante 3: Camos und Spezialvarianten
	createHashMapFromArray [
		["tree", createHashMapFromArray [
			["type", "weapon_name"],
			["special",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			],
			["regular",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			]
		]],
		["gras", createHashMapFromArray [
			["type", "weapon_name"],
			["special",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			],
			["regular",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			]
		]],
		["sand", createHashMapFromArray [
			["type", "weapon_name"],
			["special",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			],
			["regular",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			]
		]],
		["snow", createHashMapFromArray [
			["type", "weapon_name"],
			["special",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			],
			["regular",     createHashMapFromArray [
				["attachments", ["attach_type"]],
				["ammo", [[1,"clip_type"]]]
				]
			]
		]]
	];

*/



/*
	Setups Handfeuerwaffen (Dienstwaffen)
*/

private _handgun_P12=createHashMapFromArray [
	["special",     createHashMapFromArray [											/* Spezialausrüstung mit Schalldämpfer und so */
		["type", 		"BWA3_P12"],													/* keine Tarnungen verfügbar, bzw. immer die gleiche */
		["attachments", [ "BWA3_acc_LLMPI_irlaser", "BWA3_muzzle_snds_Impuls_IIA" ]],	/* Anbauten */
		["ammo", 	[ [3, "BWA3_12Rnd_45ACP_P12"] ] ]									/* 3 Magazine inkl. dem in der Waffe */
	]],
	["regular",     createHashMapFromArray [											/* reguläre Ausrüstung */
		["type", 		"BWA3_P12"],													/* keine Tarnungen verfügbar, bzw. immer die gleiche */
		["attachments", [ "BWA3_acc_LLMPI_irlaser" ]],									/* Anbauten */
		["ammo", 	[ [3, "BWA3_12Rnd_45ACP_P12"] ]]									/* 3 Magazine inkl. dem in der Waffe */
	]]
];
					
/*
	Setups Primärwaffen (Ordonanzwaffen) G38:
	G38 - 4 Tarnungen, je normal und spezial
	G38C - 4 Tarnungen, je normal und spezial
*/
private _primary_G38=createHashMapFromArray [
	["regular",     createHashMapFromArray [											/* reguläre Ausrüstung */
		["type", 		["BWA3_G38", "BWA3_G38", "BWA3_G38_tan", "BWAdd_G38"]],			/* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
		["attachments", [ 	"BWA3_optic_ZO4x30_MicroT2", 								/* Anbauten - Scope */
							[	"BWA3_bipod_Harris", 									/* Anbauten - Bipod in 4 Tarnungen */
								"BWA3_bipod_Harris_green", 
								"BWA3_bipod_Harris_tan", 
								"BWA3_bipod_Harris"]
		]],
		["ammo", 		[ 	[ 6, "BWA3_30Rnd_556x45_G36_AP" ] ]							/* 6 Magazine inkl. dem in der Waffe */
		]]
	],
	["special",     createHashMapFromArray [											/* Spezialausrüstung mit Schalldämpfer und so */
		["type", ["BWA3_G38", "BWA3_G38", "BWA3_G38_tan", "BWAdd_G38"] ],				/* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
		["attachments", [ 	"BWA3_optic_ZO4x30_MicroT2", 								/* Anbauten - Scope */
							["BWA3_bipod_Harris", 										/* Anbauten - Bipod in 4 Tarnungen */
							 "BWA3_bipod_Harris_green",
							 "BWA3_bipod_Harris_tan",
							 "BWA3_bipod_Harris"],
							["BWA3_muzzle_snds_Rotex_IIIC",								/* Anbauten - Schalldämpfer in 4 Tarnungen */
							 "BWA3_muzzle_snds_Rotex_IIIC_green",
							 "BWA3_muzzle_snds_Rotex_IIIC_tan",
							 "BWA3_muzzle_snds_Rotex_IIIC_green"]]],
		["ammo", 		[ 	[ 3, "BWA3_30Rnd_556x45_G36_SD" ],							/* 3 Magazine inkl. dem in der Waffe */
							[ 3, "BWA3_30Rnd_556x45_G36_AP" ]							/* 3 zusätzliche AP Magazine */
		]]
	]]
];
private _primary_G38C=createHashMapFromArray [
	["regular",     createHashMapFromArray [
		["type", 		["BWA3_G38C", "BWA3_G38C", "BWA3_G38C_tan", "BWAdd_G38C"] ],
		["attachments", [ 	"BWA3_optic_ZO4x30_MicroT2", 
							["BWA3_bipod_Harris", "BWA3_bipod_Harris_green", "BWA3_bipod_Harris_tan", "BWA3_bipod_Harris"] ]],
		["ammo", 		[ 	[ 6, "BWA3_30Rnd_556x45_G36_AP" ] ]
		]]
	],
	["special",     createHashMapFromArray [
		["type", 	["BWA3_G38C", "BWA3_G38C", "BWA3_G38C_tan", "BWAdd_G38C"] ],
		["attachments", [ 	"BWA3_optic_ZO4x30_MicroT2", 
							["BWA3_bipod_Harris", "BWA3_bipod_Harris_green", "BWA3_bipod_Harris_tan", "BWA3_bipod_Harris"],
							["BWA3_muzzle_snds_Rotex_IIIC", "BWA3_muzzle_snds_Rotex_IIIC_green", "BWA3_muzzle_snds_Rotex_IIIC_tan", "BWA3_muzzle_snds_Rotex_IIIC_green"]]],
		["ammo", 		[ 	[ 3, "BWA3_30Rnd_556x45_G36_SD" ],
							[ 3, "BWA3_30Rnd_556x45_G36_AP" ]
		]]
	]]
];



/* 	Das ist das standard-loadout, von dem alle anderen loadouts abgeleitet oder angepasst werden.
	Die Bewaffung und Munition ist bestandteil der Waffe und wird darüber gesteuert.
*/
private _default_loadout=createHashMapFromArray [
	/*				  		 tree								 grass								 sand								 snow					*/
	[ "goggles", 			["G_Tacttical_Clear", 				"G_Tacttical_Clear", 				"G_Tactical_Black", 				"G_Balaclava_Tropentarn"]],
	[ "helmet", 			["BWA3_OpsCore_FastMT_SOF_Fleck", 	"BWA3_OpsCore_FastMT_SOF_Multi", 	"BWA3_OpsCore_FastMT_SOF_Tropen", 	"TBW_Helm2_Schnee"]],
	[ "uniform", 			["BWA3_Uniform_Crye_G3_Fleck", 		"BWA3_Uniform_Crye_G3_Multi", 		"BWA3_Uniform_Crye_G3_Tropen", 		"PzBrig17_Uniform_Snow" ]],
	[ "vest", 				["BWA3_Vest_Fleck", 				"BWA3_Vest_Multi", 					"BWA3_Vest_Tropen", 				"TBW_Weste_Schnee"]],
	[ "backpack", 			["BWA3_AssaultPack_Fleck",			"BWA3_AssaultPack_Multi",			"BWA3_AssaultPack_Tropen",			"TBW_AssaultPack_Schnee"]],

	
	[ "handgun",			_handgun_P12 ],
	[ "primary",			_primary_G38 ],
	[ "secondary",			nil],
	[ "binocular",			nil],
	[ "tools",				[ "ItemMap", "ItemCompass", "TFAR_microdagr", "TFAR_rf7800str", "ItemMicroDAGR"] ],

	[ "uniform_content", 	[	[ 1, "ACE_EarPlugs" ],
								[ 1, "ACE_Banana" ], 
								[ 1, "acex_intelitems_notepad"],
								[ 1, "ACE_Flashlight_KSF1" ],
								[ 3, "ACE_CableTie" ],
								[ 2, "ACE_morphine" ],
								[ 1, "ACE_tourniquet" ],
								[ 2, "ACE_morphine" ],
								[15, "ACE_fieldDressing" ]
	]],
	[ "vest_content",		[	[ 1, "ACE_EntrenchingTool" ],
								[ 1, "ACE_SpraypaintRed" ],
								[ 3, "BWA3_DM51A1" ],
								[ 1, "BWA3_DM32_Yellow" ],
								[ 1, "BWA3_DM32_Orange" ],
								[ 1, "BWA3_DM25" ]
	]],
	[ "backpack_content",	[	[ 12, "ACE_fieldDressing" ],
								[  3, "ACE_morphine" ]
	]]
];



private _barett_type=createHashMapFromArray [
	["tree", 		"TBW_Barett_KSK"],
	["gras", 		"BWA3_OpsCore_FastMT_SOF_Multi"],
	["sand", 		"TBW_booniehat_hs_Tropen"],
	["snow",		"H_Watchcap_khk"]
];

private _goggles2_type=createHashMapFromArray [
	["tree", 		"BWA3_G_Combat_black"],
	["gras", 		"BWA3_G_Combat_black"],
	["sand", 		"BWA3_G_Combat_black"],
	["snow",		"BWA3_G_Combat_black"]
];

private _backpack_large_type=createHashMapFromArray[
	["tree", 		"BWA3_Kitbag_Fleck"],
	["gras", 		"BWA3_Kitbag_Multi"],
	["sand", 		"BWA3_Kitbag_Tropen"],
	["snow",		"BW_Backpack_Tropentarn"]
];

private _backpack_small_medic_type=[[
	"BWA3_AssaultPack_Fleck_Medic",
	"BWA3_AssaultPack_Multi_Medic",
	"BWA3_AssaultPack_Tropen_Medic",
	"TBW_AssaultPack_Schnee"
]];

private _backpack_large_medic_type=[[
	"BWA3_Kitbag_Fleck_Medic",
	"BWA3_Kitbag_Multi_Medic",
	"BWA3_Kitbag_Tropen_Medic",
	"BW_Backpack_Tropentarn"
]];


fnc__get_array_index_or_item = {
	params ["_thing", "_index"];
	private _ret=nil;

	if( (typeName _thing) isEqualTo "ARRAY" ) then {
		if( (count _thing) < _index) then {
			_ret=_thing select 0;
		} else {
			_ret=_thing select _index;
		};
	} else {
		_ret=_thing;
	};
	_ret;
};

fcn__set_handgun = {
	params ["_unit", "_handgun", "_camo_id"];
	private _what = _handgun getOrDefault ["type", nil];
	_what = [_what, _camo_id] call fnc__get_array_index_or_item;
	if( not isNil "_what" ) then {
		_unit addWeapon _what;
		_what = _handgun getOrDefault ["attachments", nil];
		if( not isNil "_what" ) then {
			{ _unit addHandgunItem ([_x, _camo_id] call fnc__get_array_index_or_item) } forEach _what;
		};
		_what = _handgun getOrDefault ["ammo", nil];
		if( not isNil "_what" ) then {
			private _ammo = _what select 0;
			_unit addHandgunItem (_ammo select 1); /* Legt automatisch ein Magazin in die Waffe */
			for "_i" from 2 to (_ammo select 0) do {
				_unit addItemToUniform (_ammo select 1);
			};
			for "_u" from 1 to (count _what) do {
				_ammo = _what select _u;
				for "_i" from 1 to (_ammo select 0) do {
					_unit addItemToUniform (_ammo select 1);
				};
			};
		};
	};
};

fcn__set_primary = {
	params ["_unit", "_primary", "_camo_id"];
	private _what = _primary getOrDefault ["type", nil];
	_what = [_what, _camo_id] call fnc__get_array_index_or_item;
	
	if( not isNil "_what" ) then {
		_unit addWeapon _what;
		_what = _primary getOrDefault ["attachments", nil];
		if( not isNil "_what" ) then {
			{ _unit addPrimaryWeaponItem ([_x, _camo_id] call fnc__get_array_index_or_item) } forEach _what;
		};
		_what = _primary getOrDefault ["ammo", nil];
		if( not isNil "_what" ) then {
			private _ammo = _what select 0;
			_unit addPrimaryWeaponItem (_ammo select 1); /* Legt automatisch ein Magazin in die Waffe */
			for "_i" from 2 to (_ammo select 0) do {
				_unit addItemToVest (_ammo select 1);
			};
			for "_u" from 1 to (count _what) do {
				_ammo = _what select _u;
				for "_i" from 1 to (_ammo select 0) do {
					_unit addItemToVest (_ammo select 1);
				};
			};
		};
	};
};

fnc_set_loadout = {
	params ["_target", "_player", "_params"];
	//hint "Stabsuniform XXX";
	//hint format ["Hello, %1!", _params];
	_unit = _player;
	_loadout= + [(_params select 0)] call (_params select 1);
	//systemChat format ["_loadout %1", _loadout];
	/* Alle vorhandene Items entfernen */
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	/* die Konfiguration des Loadout am Spieler mit abspeichern,
	   um später ggf. die Tarnung ändern zu können oder die richtige
	   Munition aufzunehmen (oder ähnliches). Wenn keine Tarnung vorhanden
	   ist, wird Flecktarn ("tree") als Default gesetzt.
	*/
	_player setVariable [ "TAG_selected_loadout", _loadout ];
	private _camo = _player getVariable ["TAG_selected_camo", nil];
	private _camo_id=0;
	if( isNil "_camo" ) then {
		_camo="tree";
		//hint format ["set camo to %1", _camo];
		_player setVariable [ "TAG_selected_camo", _camo ];
	} else {
		hint format ["camo: %1", _camo];
	};
	private _possible_camos=createHashMapFromArray [
		["tree", 0], ["gras", 1], ["sand", 2], ["snow", 3]
	];
	private _camo_id= _possible_camos getOrDefault [_camo, 0];

	private _mode = _player getVariable ["TAG_selected_mode", nil];
	if( isNil "_mode" ) then {
		_mode="regular";
		_player setVariable [ "TAG_selected_mode", _mode ];
	} else {

	};

	/* Uniform anziehen */
	private _uniform = _loadout getOrDefault ["uniform", nil];
	if( not isNil "_uniform" ) then {
		private _what = [_uniform, _camo_id] call fnc__get_array_index_or_item;
		if( not isNil "_what" ) then {
			_unit forceAddUniform _what;
		};
	};

	/* Weste anziehen */
	private _vest = _loadout getOrDefault ["vest", nil];
	if( not isNil "_vest" ) then {
		//hint format ["vest: %1", _vest];
		private _what = [_vest, _camo_id] call fnc__get_array_index_or_item;
		if( not isNil "_what") then {
			_unit addVest _what;
		};
	};

	/* Rucksack anziehen */
	private _backpack= _loadout getOrDefault ["backpack", nil];
	if( not isNil "_backpack" ) then {
		private _what = [_backpack, _camo_id] call fnc__get_array_index_or_item;
		if( not isNil "_what" ) then {
			_unit addBackpack _what;
		};
	};

	/* Brille anziehen */
	private _goggles = _loadout getOrDefault ["goggles", nil];
	//hint format ["goggles: %1 (%2)", _goggles, _camo];
	if( not isNil "_goggles" ) then {
		private _what = [_goggles, _camo_id] call fnc__get_array_index_or_item;
		//hint format ["goggles: %1", _what];
		if( not isNil "_what" ) then {
			_unit addGoggles _what;
		};
	};

	/* Helm anziehen */
	private _helmet = _loadout getOrDefault ["helmet", nil];
	if( not isNil "_helmet" ) then {
		private _what = [_helmet, _camo_id] call fnc__get_array_index_or_item;
		if( not isNil "_what" ) then {
			_unit addHeadgear _what;
		};
	};

	/* Helm anziehen */
	private _binocular = _loadout getOrDefault ["binocular", nil];
	if( not isNil "_binocular" ) then {
		private _what = [_binocular, _camo_id] call fnc__get_array_index_or_item;
		if( not isNil "_what" ) then {
			_unit addWeapon _what;
		};
	};

	/* Tools ausrüsten */
	private _tools = _loadout getOrDefault ["tools", nil];
	if( not isNil "_tools" ) then {
		{ _unit linkItem _x } forEach _tools;
	};

	/* Handwaffe ausrüsten, Attachments anbringen und Munition in die Uniform */
	private _handgun= _loadout getOrDefault ["handgun", nil];
	if( not isNil "_handgun" ) then {
		private _what = _handgun getOrDefault ["type", nil];
		
		if( not isNil "_what" ) then { /* apparently variant 1 */
			//systemChat format ["_handgun: %1", _handgun];
			[_unit, _handgun, _camo_id] call fcn__set_handgun;
		} else { /* Variant 2 or 3 */
			private _what_mode = _handgun getOrDefault [_mode, nil];
			//systemChat format ["_handgun2: %1", _what_mode];
			[_unit, _what_mode, _camo_id] call fcn__set_handgun;
		};
	};
	
	/* Primäre Waffe ausrüsten, Attachments anbringen und Munition in die Weste */
	private _primary= _loadout getOrDefault ["primary", nil];
	systemChat format ["primary: %1", _primary];
	if( not isNil "_primary" ) then {
		private _what = _primary getOrDefault ["type", nil];
		if( not isNil "_what" ) then { /* apparently variant 1 */
			systemChat format ["_what: %1", _what];
			[_unit, _primary, _camo_id] call fcn__set_primary;
		} else { /* Variant 2 or 3 */
			private _what_mode = _primary getOrDefault [_mode, nil];
			systemChat format ["_what_mode: %1", _what_mode];
			[_unit, _what_mode, _camo_id] call fcn__set_primary;
		};
	};

	private _uniform_content= _loadout getOrDefault ["uniform_content", nil];
	if( not isNil "_uniform_content" ) then {
		{ 
			for "_i" from 1 to (_x select 0) do {
				hint format ["uniform: %1 %2", _x select 0, _x select 1];
				_unit addItemToUniform (_x select 1);
			};
		} forEach _uniform_content;
	};

	private _vest_content= _loadout getOrDefault ["vest_content", nil];
	if( not isNil "_vest_content" ) then {
		{ 
			for "_i" from 1 to (_x select 0) do {
				_unit addItemToVest (_x select 1);
			};
		} forEach _vest_content;
	};

	private _backpack_content= _loadout getOrDefault ["backpack_content", nil];
	systemChat format ["_backpack_content2: %1", _backpack_content];
	if( not isNil "_backpack_content" ) then {
			//systemChat format ["_backpack_content: %1", _backpack_content];
		{ 
			for "_i" from 1 to (_x select 0) do {
				_unit addItemTobackpack(_x select 1);
			};
		} forEach _backpack_content;
	};
};

camouflage_change = {
	params ["_target", "_player", "_params"];
	_unit = _player;
	private _camo = _params;
	
	private _camo2 = _player getVariable ["TAG_selected_camo", nil];
	hint format ["a: %1, b: %2", _camo2, _camo];
	if( not isNil "_camo2" ) then {
		if( not (_camo2 isEqualTo _camo) ) then {
			_player setVariable [ "TAG_selected_camo", _camo ];
			private _loadout = _player getVariable ["TAG_selected_loadout", nil];
			if( not isNil "_loadout" ) then {
				[_target, _unit, _loadout ] call fnc_set_loadout;
			};
		};
	};

	

};


create_loadout_action = {
	params ["_loadout_name", "_loadout", ["_modifier_call", nil]];
	//systemChat "ok";
	private _action = [_loadout_name + "_item",_loadout_name,"", fnc_set_loadout ,{true},{}, _loadout, [0,0,0], 100, [false, true, true, false, false], {} ] call ace_interact_menu_fnc_createAction;

	_action;
};

fcn_loadout_menu={
	params ["_object", "_menu_tree", "_default_loadout", ["_path", ["ACE_MainActions"]]];
	private _prefix_num=0;
	{
		private _menu_name=_x;
		private _menu_id=_menu_name trim ["äöüÖÄÜß", 0];
		_menu_id=_menu_id splitString "-,. äöüÖÄÜß";
		_menu_id=_menu_id joinString "";
		_menu_id= format ["%1_%2", _prefix_num, _menu_id];
		private _submenu=_y;
		private _action=nil;

		if( (typeName _submenu) isEqualTo "CODE" ) then {
			//private _this_loadout= +([_default_loadout] call _submenu);
			//systemChat format ["lm2: %1 - %2", _path, _this_loadout];
			_action=[ _menu_id, _menu_name, "", (fnc_set_loadout), {true}, {}, [_default_loadout, _submenu], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};
		if( (typeName _submenu) isEqualTo "ARRAY" ) then {
			_action=[ _menu_id, _menu_name, "", (_submenu select 0), {true}, {}, (_submenu select 1), [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};
		if( (typeName _submenu) isEqualTo "HASHMAP" ) then {
			_action=[ _menu_id, _menu_name, "", {}, {true}, {}, objNull, [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};

		
		if( not isNil "_action" ) then {
			[_object, 0, _path, _action] call ace_interact_menu_fnc_addActionToObject;
			_prefix_num=_prefix_num+1;
			private _new_path = + _path + [_menu_id];
			if( (typeName _submenu) isEqualTo "HASHMAP" ) then {
				[_object, _submenu, _default_loadout, _new_path] call fcn_loadout_menu;
			};
		};

	} forEach _menu_tree;

	true;

};

fcn_Truppfueher={
	params ["_in_loadout"];
	systemChat "fcn_Truppfueher";
	private _loadout = + _in_loadout;
	_loadout set ["primary", _primary_G38C ]; 																	/* Mit der Kompaktversion ersetzen */
	private _g= _loadout get "primary";
	systemChat format ["g %1", _primary_G38C];
	_loadout set ["tools", [ "ItemMap", "ItemCompass", "ItemWatch", "TFAR_anprc152", "ItemAndroid"]];			/* leicht andere Tools */	
	_loadout set ["binocular", "ACE_Vector"];																	/* VectorIV Fernglas */

	/* ok, Nerd-Variante: Wir holen uns das Array des Rucksackinhalts, hängen das HunterIR an und schreiben es zurück. */
	private _bp=_loadout get "backpack_content";
	_bp append [[ 1, "ACE_HuntIR_monitor"]];

	_loadout set ["backpack_content", _bp];
	//systemChat format ["fcn %1", _loadout];
	/* weil wir es können, erstzen wir die Weste JPC Leader */
	_loadout set [ "vest", ["BWA3_Vest_JPC_Leader_Fleck", "BWA3_Vest_JPC_Leader_Multi", "BWA3_Vest_JPC_Leader_Tropen", "TBW_Weste_Schnee"]];

	_loadout;	/* returnen des loadouts */
};
fcn_TruppfueherFunk={
	params ["_in_loadout"];
	systemChat "fcn_TruppfueherFunk";
	/* ist erstmal das gleiche wie der Truppführer */
	private _loadout = [_in_loadout] call fcn_Truppfueher;
	_loadout set ["backpack", ["TFAR_rt1523g_bwmod", "TFAR_rt1523g_bwmod", "TFAR_rt1523g", "TFAR_rt1523g"]];

	_loadout;	/* returnen des loadouts */
};
fcn_Gruppenfueher={
	params ["_in_loadout"];
	systemChat "fcn_Gruppenfueher";
	/* ist erstmal das gleiche wie der Truppführer */
	private _loadout = [_in_loadout] call fcn_Truppfueher;

	_loadout;	/* returnen des loadouts */
};
fcn_GruppenfueherFunk={
	params ["_in_loadout"];
	systemChat "fcn_GruppenfueherFunk";
	/* ist erstmal das gleiche wie der TruppführerFunk */
	private _loadout = [_in_loadout] call fcn_TruppfueherFunk;

	_loadout;	/* returnen des loadouts */
};

fcn_Sanitaeter={
	params ["_in_loadout"];
	systemChat "fcn_Sanitaeter";
	private _loadout = _in_loadout;
	_loadout set ["primary", _primary_G38C ];	/* Mit der Kompaktversion ersetzen */
	_loadout set ["backpack", ["BWA3_AssaultPack_Fleck_Medic", "BWA3_AssaultPack_Multi_Medic", "BWA3_AssaultPack_Tropen_Medic", "TBW_AssaultPack_Schnee"]];																/* VectorIV Fernglas */
	_loadout set [ "vest", ["BWA3_Vest_Medic_Fleck", "BWA3_Vest_Medic_Multi", "BWA3_Vest_Medic_Tropen", "TBW_Weste_Schnee"]];

	/* so richtig viel medic zeug */
	private _bp=[	[ 42, "ACE_fieldDressing" ],
					[ 12, "ACE_morphine" ],
					[ 12, "ACE_epinephrine" ],
					[ 12, "ACE_adenosine" ],
					[  8, "ACE_splint" ],
					[  2, "ACE_tourniquet" ],
					[ 12, "ACE_salineIV_250" ],
					[  1, "ACE_personalAidKit" ]
	];

	_loadout set ["backpack_content", _bp];
	systemChat format ["fcn %1", _loadout];
	/* weil wir es können, erstzen wir die Weste JPC Leader */

	_loadout;	/* returnen des loadouts */
};

fcn_Aufklaerer={};
fcn_Funker={};
fcn_UAVOP={};
fcn_dummy={ hint "x"; };
private _unit_classes=createHashMapFromArray [
	[ "Leichte Infantrie", createHashMapFromArray [
			["Truppführer", createHashMapFromArray [
				[ "Rucksack", fcn_Truppfueher],
				[ "Langstreckenfunk", fcn_TruppfueherFunk]
			]],
			["Gruppenführer", createHashMapFromArray [
				[ "Rucksack", fcn_Gruppenfueher],
				[ "Langstreckenfunk", fcn_GruppenfueherFunk]
			]],
			["Sanitäter", fcn_Sanitaeter],
			["Aufklärer", fcn_Sanitaeter],
			["Funker", fcn_Sanitaeter],
			["UAV Operator", fcn_Sanitaeter]
		]
	]/*,
	[ "Infantrie", createHashMapFromArray [
			["Pionier", fcn_dummy],
			["Schütze", fcn_dummy],
			["Gruppenscharfschütze", fcn_dummy],
			["Präzisionsschütze", fcn_dummy],
			["Munitionsträger", fcn_dummy]
		]
	],
	[ "Schwere Infantrie", createHashMapFromArray [
			["Schütze MG3", fcn_dummy],
			["Schütze MG5", fcn_dummy],
			["Grenadier AGL", fcn_dummy],
			["Grenadier PZ3", fcn_dummy],
			["Grenadier Leuchtbüchse", fcn_dummy],
			["Grenadier Fliegerfaust 2", fcn_dummy]
		]
	],
	[ "Sonderausrüstung", createHashMapFromArray [
			[ "Stabsuniform", fcn_dummy ],
			["Pilot", fcn_dummy],
			["Panzerbesatzung", fcn_dummy]
		]
	],
	[ "Tarnfarbe", createHashMapFromArray [
			["Flecktarn", [camouflage_change, "tree"]],
			["Multitarn", [camouflage_change, "gras"]],
			["Tropentarn", [camouflage_change, "sand"]],
			["Schneetarn", [camouflage_change, "snow"]]
		]
	],
	[ "Extras", createHashMapFromArray [
			["mit Schalldämpfer", [camouflage_change, "suppressor"]],
			["ohne Schalldämpfer", [camouflage_change, ""]],
			["mit Nachtsicht", [camouflage_change, "nightview"]],
			["ohne Nachtsicht", [camouflage_change, ""]]
		]
	]*/
];



[_object, true] call ace_arsenal_fnc_initBox;

[ _object, _unit_classes, _default_loadout ] call fcn_loadout_menu;

//systemChat format ["object: %1", _object];



//_action = ["StabsuniformN","Stabsuniform","", fnc_set_loadout ,{true},{}, { private _loadout=_loadout_map; _loadout set [ "primary", nil]; _loadout; }, [0,0,0], 100, [false, true, true, false, false], {systemChat "Modifier";} ] call ace_interact_menu_fnc_createAction;

/*
[_object, 0, ["ACE_MainActions"], ["Stabsuniform", _loadout_stab, {}] call create_loadout_action ] call ace_interact_menu_fnc_addActionToObject;

_action = ["Camo","Tarnfarbe","", camouflage_change ,{true},{}, objNull, [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Camo_tree","Flecktarn","", camouflage_change,{true},{}, "tree", [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "Camo"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Camo_gras","Multitarn","", camouflage_change,{true},{}, "gras", [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "Camo"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Camo_sand","Tropentarn","", camouflage_change,{true},{}, "sand", [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "Camo"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Camo_snow","Schneetarn","", camouflage_change,{true},{}, "snow", [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "Camo"], _action] call ace_interact_menu_fnc_addActionToObject;
*/
/*
	Leichte Infantrie

_action = ["AusruestungLeicht","Leichte Infantrie","",{ hint "Leichte Infantrie";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungSquadLeader","Truppführer","",{ hint "Truppführer";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungGroupLeader","Gruppenführer","",{ hint "Gruppenführer";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungMedic","Sanitäter","",{ hint "Sanitäter";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungRecon","Aufklärer","",{ hint "Aufklärer";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungRadio","Funker","",{ hint "Funker";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungUAV","Drohnenoperator","",{ hint "Drohnenoperator";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungLeicht"], _action] call ace_interact_menu_fnc_addActionToObject;
*/
/*
	Infantrie

_action = ["AusruestungNormal","Infantrie","",{ hint "Infantrie";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungPioneer","Pionier","",{ hint "Pionier";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungNormal"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungRifleman","Schütze","",{ hint "Schütze";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungNormal"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungSniper1","Gruppenscharfschütze","",{ hint "Gruppenscharfschütze";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungNormal"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungSniper2","Präzisionsschütze","",{ hint "Präzisionsschütze";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungNormal"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungCarrier","Munitionsträger","",{ hint "Munitionsträger";},{true},{},[objNull], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungNormal"], _action] call ace_interact_menu_fnc_addActionToObject;
*/
/*
	Schwere Infantrie

_action = ["AusruestungSchwer","Schwere Infantrie","",{ hint "Schwere Infantrie";},{true},{},[parameters], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungMG","MG Schütze","",{ hint "MG Schütze";},{true},{},[parameters], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungSchwer"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["AusruestungGrenadier","Grenadier","",{ hint "Grenadier";},{true},{},[parameters], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions", "AusruestungSchwer"], _action] call ace_interact_menu_fnc_addActionToObject;

*/
