/*
	little helper: some items are either arrays (like for items for camo) or just
	a single item (if there's no camo available). 
*/
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

/*
	add the handgun weapon, add it's attachments and ammunition. primary ammo always goes to the
	uniform.
*/
fcn__set_handgun = {
	params ["_unit", "_handgun", "_camo_id"];
	private _what = _handgun getOrDefault ["type", nil];
	private _first_ammo=nil;
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
			_first_ammo=(_ammo select 1);
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
	_first_ammo;
};

/*
	add the primary weapon, add it's attachments and ammunition. primary ammo always goes to the
	vest.
*/
fcn__set_primary = {
	params ["_unit", "_primary", "_camo_id"];
	private _what = _primary getOrDefault ["type", nil];
	private _first_ammo=nil;
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
			_first_ammo=(_ammo select 1);
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
	_first_ammo;
};

fcn__set_secondary = {
	params ["_unit", "_secondary", "_camo_id"];
	private _what = _secondary getOrDefault ["type", nil];
	private _first_ammo=nil;
	_what = [_what, _camo_id] call fnc__get_array_index_or_item;
	if( not isNil "_what" ) then {
		_unit addWeapon _what;
		
		_what = _secondary getOrDefault ["attachments", nil];
		if( not isNil "_what" ) then {
			{ _unit addSecondaryWeaponItem ([_x, _camo_id] call fnc__get_array_index_or_item) } forEach _what;
		};
		_what = _secondary getOrDefault ["ammo", nil];
		if( not isNil "_what" ) then {
			private _ammo = _what select 0;
			_unit addSecondaryWeaponItem (_ammo select 1); /* Legt automatisch ein Magazin in die Waffe */
			_first_ammo=(_ammo select 1);
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
	_first_ammo;
};

/*
	we store the actual camouflage in a player tag variable - if none is set, we set it to "tree". 
	We also have the actual loadout of the player stored as a tag on him.
	if we change the camouflage, just call the loadout function again to change the camo. 
	be aware: for now it will reset the ammo. maybe we need a flag to skip this? 
*/
camouflage_change = {
	params ["_target", "_player", "_params"];
	systemChat format ["camo a: %1, b: %2", _camo2, _camo];
	_unit = _player;
	private _camo = _params;
	
	private _camo2 = _player getVariable ["TAG_selected_camo", nil];
	
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

special_change = {
	params ["_target", "_player", "_params"];
	_unit = _player;
	private _mode = _params;
	
	private _mode2 = _player getVariable ["TAG_selected_mode", nil];
	systemChat format ["mode a: %1, b: %2", _mode2, _mode];
	
	if( not isNil "_mode2" ) then {
		if( not (_mode2 isEqualTo _mode) ) then {
			_player setVariable [ "TAG_selected_mode", _mode ];
			private _loadout = _player getVariable ["TAG_selected_loadout", nil];
			if( not isNil "_loadout" ) then {
				[_target, _unit, _loadout ] call fnc_set_loadout;
			};
		};
	};
};

/*
	here we process the actual loadout and assign it to the user. for reasons, in previous code
	iterations, the camo was called "tree", "gras", "sand" and "snow", along with corresponding
	hashmaps. but this bloated the structures, so I changed it to an array. However, for some
	mysterious reasons, I've left the camo selection with the strings and to a manual conversion 
	to the respecitve number/array index. maybe it's easier to debug to see the string instead of
	the number...
*/
fnc_set_loadout = {
	params ["_target", "_player", "_params"];
	_unit = _player;
	_loadout=_params;
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

	if( not isNil "_mode") then {
		systemChat format ["mode is %1", _mode];
		if(_mode isEqualTo "special") then {
			private _nightvision= _loadout getOrDefault ["nightvision", nil];
			if( not isNil "_nightvision" ) then {
				private _what = [_nightvision, _camo_id] call fnc__get_array_index_or_item;
				if( not isNil "_what" ) then {
					_unit linkItem _what;
				};
			};
			
		};
	};

	/* Brille anziehen */
	private _goggles = _loadout getOrDefault ["goggles", nil];
	//systemChat format ["goggles a: %1 (%2)", _goggles, _camo];
	if( not isNil "_goggles" ) then {
		private _what = [_goggles, _camo_id] call fnc__get_array_index_or_item;
		//systemChat format ["goggles b: %1", _what];
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
	private _handgun_ammo=nil;
	if( not isNil "_handgun" ) then {
		private _what = _handgun getOrDefault ["type", nil];
		
		if( not isNil "_what" ) then { /* apparently variant 1 */
			_handgun_ammo=([_unit, _handgun, _camo_id] call fcn__set_handgun);
		} else { /* Variant 2 or 3 */
			private _what_mode = _handgun getOrDefault [_mode, nil];
			_handgun_ammo=([_unit, _what_mode, _camo_id] call fcn__set_handgun);
		};
	};
	
	/* Primäre Waffe ausrüsten, Attachments anbringen und Munition in die Weste */
	private _primary= _loadout getOrDefault ["primary", nil];
	private _primary_ammo=nil;
	if( not isNil "_primary" ) then {
		private _what = _primary getOrDefault ["type", nil];
		if( not isNil "_what" ) then { /* apparently variant 1 */
			_primary_ammo=([_unit, _primary, _camo_id] call fcn__set_primary);
		} else { /* Variant 2 or 3 */
			private _what_mode = _primary getOrDefault [_mode, nil];
			_primary_ammo=([_unit, _what_mode, _camo_id] call fcn__set_primary);
		};
	};

	/* Sekundäre Waffe ausrüsten, Attachments anbringen und Munition in die Weste */
	private _secondary= _loadout getOrDefault ["secondary", nil];
	private _secondary_ammo=nil;
	if( not isNil "_secondary" ) then {
		private _what = _secondary getOrDefault ["type", nil];
		if( not isNil "_what" ) then { /* apparently variant 1 */
			_secondary_ammo=([_unit, _secondary, _camo_id] call fcn__set_secondary);
		} else { /* Variant 2 or 3 */
			private _what_mode = _secondary getOrDefault [_mode, nil];
			_secondary_ammo=([_unit, _what_mode, _camo_id] call fcn__set_secondary);
		};
	};

	private _uniform_content= _loadout getOrDefault ["uniform_content", nil];
	if( not isNil "_uniform_content" ) then {
		{ 
			for "_i" from 1 to (_x select 0) do {
				//hint format ["uniform: %1 %2", _x select 0, _x select 1];
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
	if( not isNil "_backpack_content" ) then {
		{ 
			for "_i" from 1 to (_x select 0) do {
				if( (_x select 1) isEqualTo "__extra_primary_ammo") then {
					_unit addItemTobackpack _primary_ammo;
				} else {
					_unit addItemTobackpack (_x select 1);
				}
			};
		} forEach _backpack_content;
	};
};



/*
	creates the ACE Menu specified in _menu_tree on object _object and provides
	a default loadout structure in _default_loadout.
	For submenu pathes (not names) most of special characters are trimmed, if some
	characters are missing, just add.
	IMPORTANT: this is a recursive method!
*/
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
			/* if we have a loadout function, make a copy of our default loadout and call the function to
			   create the actual loadout. 
			   this part is tricky: if we pass the loadout function and default loadout upon actual calling this 
			   menu item, it seems that some other variables have gone out of scope and are just empty.
			   for this reason we have to create every loadout on menu initialization and just store the resulting
			   loadout along in the action. 
			*/
			private _lo= +_default_loadout;
			private _le=(_lo call _submenu);
			_action=[ _menu_id, _menu_name, "", (fnc_set_loadout), {true}, {}, _le, [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};
		if( (typeName _submenu) isEqualTo "ARRAY" ) then {
			//systemChat format ["menu: %1 a: %2, b: %3", _menu_name, submenu select 0, (_submenu select 1)];
			/* special case, we assume an array to contain a callable function and some sort of parameter. this way we can specify something to toggle or so */
			_action=[ _menu_id, _menu_name, "", (_submenu select 0), {true}, {}, (_submenu select 1), [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};
		if( (typeName _submenu) isEqualTo "HASHMAP" ) then {
			/* a hashmap is our actual menu - or better submenu */
			_action=[ _menu_id, _menu_name, "", {}, {true}, {}, objNull, [0,0,0], 100] call ace_interact_menu_fnc_createAction;
		};

		
		if( not isNil "_action" ) then {
			[_object, 0, _path, _action] call ace_interact_menu_fnc_addActionToObject;
			_prefix_num=_prefix_num+1;
			private _new_path = + _path + [_menu_id];
			if( (typeName _submenu) isEqualTo "HASHMAP" ) then {
				/* DANGER: here comes the actual recursive part */
				[_object, _submenu, _default_loadout, _new_path] call fcn_loadout_menu;
			};
		};

	} forEach _menu_tree;

	true;

};
