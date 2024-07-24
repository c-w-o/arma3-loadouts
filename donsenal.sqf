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

/*   Es gibt zwei Varianten um Waffen zu definieren - entweder mit Spezialvariante oder ohne.
  Üblicherweise ist die Spezialvariante mit Schalldämpfer.

Variante 1 - keine Spezialvarianten
  private _weapon = createHashMapFromArray [
    ["type", "weapon_name"],
    ["attachments", ["attach_type"]],
    ["ammo", [[1,"clip_type"]]]
  ];

Variante 2: mit Spezialvarianten

  private _weapon = createHashMapFromArray [
    ["special",     createHashMapFromArray [
      ["type", "weapon_name"],
      ["attachments", ["attach_type"]],
      ["ammo", [[1,"clip_type"]]]
    ]],
    ["regular",     createHashMapFromArray [
      ["type", "weapon_name"],
      ["attachments", ["attach_type"]],
      ["ammo", [[1,"clip_type"]]]
    ]]
  ];

Für jeden "type" und jedes Element in "attachments" gilt, dass es entweder ein einfacher String
oder ein Array aus 4 String sein kann - je ob es Tarnvarianten gibt oder nicht:
["type", "weapon_name"]
["type", ["weapon_name", "weapon_name_multi", "weapon_name_tan", "weapon_name_snow"]]

["attachments", ["attach_type"]]
["attachments", [["attach_type_wood", "attach_type_multi", "attach_type_tan", "attach_type_snow"]]]

*/


/*
  Setups Handfeuerwaffen (Dienstwaffen), keine Tarnungen aber Spezialvarianten
*/

private _handgun_P12=createHashMapFromArray [
  ["special",     createHashMapFromArray [                        /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",     "BWA3_P12"],                                     /* keine Tarnungen verfügbar, bzw. immer die gleiche */
    ["attachments", [ "BWA3_acc_LLMPI_irlaser", "BWA3_muzzle_snds_Impuls_IIA" ]],  /* Anbauten */
    ["ammo",   [ [3, "BWA3_12Rnd_45ACP_P12"] ] ]                  /* 3 Magazine inkl. dem in der Waffe */
  ]],
  ["regular",     createHashMapFromArray [                        /* reguläre Ausrüstung */
    ["type",     "BWA3_P12"],                                     /* keine Tarnungen verfügbar, bzw. immer die gleiche */
    ["attachments", [ "BWA3_acc_LLMPI_irlaser" ]],                /* Anbauten */
    ["ammo",   [ [3, "BWA3_12Rnd_45ACP_P12"] ]]                   /* 3 Magazine inkl. dem in der Waffe */
  ]]
];
          
/*
  Setups Primärwaffen (Ordonanzwaffen) G38:
  G38 - 4 Tarnungen, je normal und spezial
  G38C - 4 Tarnungen, je normal und spezial
*/
private _primary_G38=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                                    /* reguläre Ausrüstung */
    ["type",     ["BWA3_G38", "BWA3_G38", "BWA3_G38_tan", "BWAdd_G38"]],      /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2_sand", 
                        "BWA3_optic_ZO4x30i_MicroT2" ],
                      [ "BWA3_bipod_Harris",
                        "BWA3_bipod_Harris_green",
                        "BWA3_bipod_Harris_tan",
                        "BWA3_bipod_Harris"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
              
    ]],
    ["ammo",        [ [ 6, "BWA3_30Rnd_556x45_G36_AP" ]                    /* 6 Magazine inkl. dem in der Waffe */
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [                                    /* Spezialausrüstung mit Schalldämpfer und so */
    ["type", ["BWA3_G38", "BWA3_G38", "BWA3_G38_tan", "BWAdd_G38"] ],         /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_ZO4x30_MicroT2_NSV",                      /* Anbauten - Scope */
                        "BWA3_optic_ZO4x30_MicroT2_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_brown_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_NSV"],                 
                      [ "BWA3_bipod_Harris",                                  /* Anbauten - Bipod in 4 Tarnungen */
                        "BWA3_bipod_Harris_green",
                        "BWA3_bipod_Harris_tan",
                        "BWA3_bipod_Harris"],
                      [ "BWA3_muzzle_snds_Rotex_IIIC",                        /* Anbauten - Schalldämpfer in 4 Tarnungen */
                        "BWA3_muzzle_snds_Rotex_IIIC_green",
                        "BWA3_muzzle_snds_Rotex_IIIC_tan",
                        "BWA3_muzzle_snds_Rotex_IIIC"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 3, "BWA3_30Rnd_556x45_G36_AP" ],                    /* 3 Magazine inkl. dem in der Waffe */
                      [ 3, "BWA3_30Rnd_556x45_G36_SD" ]                   /* 3 zusätzliche AP Magazine */
                    ]
    ]]
  ]
];
private _primary_G38C=createHashMapFromArray [
  ["regular",     createHashMapFromArray [
    ["type",     ["BWA3_G38C", "BWA3_G38C", "BWA3_G38C_tan", "BWAdd_G38C"] ],
    ["attachments", [ [ "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2_sand", 
                        "BWA3_optic_ZO4x30i_MicroT2"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 6, "BWA3_30Rnd_556x45_G36_AP" ]
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [
    ["type",        ["BWA3_G38C", "BWA3_G38C", "BWA3_G38C_tan", "BWAdd_G38C"] ],
    ["attachments", [ [ "BWA3_optic_ZO4x30_MicroT2_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_brown_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_brown_NSV"], 
                      [ "BWA3_muzzle_snds_Rotex_IIIC",                /* Anbauten - Schalldämpfer in 4 Tarnungen */
                        "BWA3_muzzle_snds_Rotex_IIIC_green",
                        "BWA3_muzzle_snds_Rotex_IIIC_tan",
                        "BWA3_muzzle_snds_Rotex_IIIC"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 3, "BWA3_30Rnd_556x45_G36_AP" ],
                      [ 3, "BWA3_30Rnd_556x45_G36_SD" ] 
                    ]
    ]]
  ]
];
private _primary_G38AGL=createHashMapFromArray [
  ["regular",     createHashMapFromArray [
    ["type",        ["BWA3_G38_AG40", "BWA3_G38_AG40", "BWA3_G38_AG40_tan", "BWAdd_G38_AG"] ],
    ["attachments", [ [ "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2", 
                        "BWA3_optic_ZO4x30i_MicroT2_sand", 
                        "BWA3_optic_ZO4x30i_MicroT2"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 6, "BWA3_30Rnd_556x45_G36_AP" ] 
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [
    ["type",        ["BWA3_G38_AG40", "BWA3_G38_AG40", "BWA3_G38_AG40_tan", "BWAdd_G38_AG"] ],
    ["attachments", [ [ "BWA3_optic_ZO4x30_MicroT2_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_brown_NSV", 
                        "BWA3_optic_ZO4x30_MicroT2_brown_NSV"], 
                      [ "BWA3_muzzle_snds_Rotex_IIIC",                /* Anbauten - Schalldämpfer in 4 Tarnungen */
                        "BWA3_muzzle_snds_Rotex_IIIC_green",
                        "BWA3_muzzle_snds_Rotex_IIIC_tan",
                        "BWA3_muzzle_snds_Rotex_IIIC"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 3, "BWA3_30Rnd_556x45_G36_AP" ],
                      [ 3, "BWA3_30Rnd_556x45_G36_SD" ] 
                    ]
    ]]
  ]
];
private _primary_G28=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                      /* reguläre Ausrüstung */
    ["type",       "BWA3_G28"],                        /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front",                 /* Anbauten - Scope */
                      [ "BWA3_bipod_Harris",                   /* Anbauten - Bipod in 4 Tarnungen */
                        "BWA3_bipod_Harris_green", 
                        "BWA3_bipod_Harris_tan", 
                        "BWA3_bipod_Harris"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 6, "BWA3_20Rnd_762x51_G28_AP" ]              /* 6 Magazine inkl. dem in der Waffe */
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [                      /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",       "BWA3_G28"],                        /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front_NSV",           /* Anbauten - Scope */
                      [ "BWA3_bipod_Harris",                     /* Anbauten - Bipod in 4 Tarnungen */
                        "BWA3_bipod_Harris_green",
                        "BWA3_bipod_Harris_tan",
                        "BWA3_bipod_Harris"],
                        "BWA3_muzzle_snds_Rotex_IIA",
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 3, "BWA3_20Rnd_762x51_G28_AP" ],
                      [ 3, "BWA3_20Rnd_762x51_G28_SD"]            /* 3 zusätzliche AP Magazine */
                    ]
    ]]
  ]
];
private _primary_G29=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                      /* reguläre Ausrüstung */
    ["type",       "BWA3_G29"],                        /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front",                 /* Anbauten - Scope */
                      [ "BWA3_bipod_Harris",                   /* Anbauten - Bipod in 4 Tarnungen */
                        "BWA3_bipod_Harris_green", 
                        "BWA3_bipod_Harris_tan", 
                        "BWA3_bipod_Harris"]
    ]],
    ["ammo",        [ [ 3, "BWA3_10Rnd_86x70_G29" ]                /* 3 Magazine inkl. dem in der Waffe */
                    ]      
    ]]
  ],
  ["special",     createHashMapFromArray [                      /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",       "BWA3_G29"],                        /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front_NSV",           /* Anbauten - Scope */
                      [ "BWA3_bipod_Harris",                     /* Anbauten - Bipod in 4 Tarnungen */
                        "BWA3_bipod_Harris_green",
                        "BWA3_bipod_Harris_tan",
                        "BWA3_bipod_Harris"],
                        "BWA3_muzzle_snds_Rotex_Monoblock"
    ]],
    ["ammo",        [ [ 6, "BWA3_10Rnd_86x70_G29" ]                /* 3 Magazine inkl. dem in der Waffe */
                    ]
    ]]
  ]
];
private _primary_G82=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                      /* reguläre Ausrüstung */
    ["type",        ["BWA3_G82", "BWA3_G82", "BWAdd_G82", "BWAdd_G82"]],    /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front"
    ]],
    ["ammo",        [ [ 3, "BWA3_10Rnd_127x99_G82_AP" ],                /* 3 Magazine inkl. dem in der Waffe */
                      [ 1, "BWA3_10Rnd_127x99_G82_Raufoss" ]
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [                      /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",        ["BWA3_G82", "BWA3_G82", "BWAdd_G82", "BWAdd_G82"]],    /* keine Tarnungen verfügbar */
    ["attachments", [ "BWA3_optic_PMII_DMR_MicroT1_front_NSV"]],
    ["ammo",        [ [ 3, "BWA3_10Rnd_127x99_G82_AP" ],                /* 3 Magazine inkl. dem in der Waffe */
                      [ 2, "BWA3_10Rnd_127x99_G82_Raufoss" ] 
                    ]
    ]]
  ]
];

private _primary_MG4=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                      /* reguläre Ausrüstung */
    ["type",        ["BWA3_MG4", "BWA3_MG4", "BWAdd_MG4", "BWAdd_MG4"]],      /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_EOTech552", 
                        "BWA3_optic_EOTech552_green", 
                        "BWA3_optic_EOTech552_tan", 
                        "BWA3_optic_EOTech552"], 
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
                    ]
    ]],
    ["ammo",        [ [ 2, "BWA3_200Rnd_556x45" ]              /* 6 Magazine inkl. dem in der Waffe */
                    ]
    ]]
  ],
  ["special",     createHashMapFromArray [                      /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",        ["BWA3_MG4", "BWA3_MG4", "BWAdd_MG4", "BWAdd_MG4"]],        /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_EOTech552", 
                        "BWA3_optic_EOTech552_green", 
                        "BWA3_optic_EOTech552_tan", 
                        "BWA3_optic_EOTech552_tan"], 
                        "BWA3_muzzle_snds_Rotex_IIA",
                      [ "BWA3_muzzle_snds_Rotex_IIIC",                /* Anbauten - Schalldämpfer in 4 Tarnungen */
                        "BWA3_muzzle_snds_Rotex_IIIC_green",
                        "BWA3_muzzle_snds_Rotex_IIIC_tan",
                        "BWA3_muzzle_snds_Rotex_IIIC_tan"],
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 2, "BWA3_200Rnd_556x45" ]              /* 3 Magazine inkl. dem in der Waffe */
                    ]
    ]]
];

private _primary_MG5=createHashMapFromArray [
  ["regular",     createHashMapFromArray [                      /* reguläre Ausrüstung */
    ["type",     ["BWA3_MG5", "BWA3_MG5", "BW3_MG5_tan", "BWAdd_MG5"]],      /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_EOTech552", 
                        "BWA3_optic_EOTech552_green", 
                        "BWA3_optic_EOTech552_tan", 
                        "BWA3_optic_EOTech552"], 
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 2, "BWA3_120Rnd_762x51_soft" ] ]              /* 6 Magazine inkl. dem in der Waffe */
                ]
  ]],
  ["special",     createHashMapFromArray [                      /* Spezialausrüstung mit Schalldämpfer und so */
    ["type",        ["BWA3_MG5", "BWA3_MG5", "BW3_MG5_tan", "BWAdd_MG5"]],        /* alle 4 Tarnungen verfügbar (Wald, Gras, Sand, Schnee) */
    ["attachments", [ [ "BWA3_optic_EOTech552", 
                        "BWA3_optic_EOTech552_green", 
                        "BWA3_optic_EOTech552_tan", 
                        "BWA3_optic_EOTech552"], 
                        "BWA3_muzzle_snds_Rotex_IIA",
                      [ "BWA3_acc_LLM01_irlaser",
                        "BWA3_acc_LLM01_irlaser_green",
                        "BWA3_acc_LLM01_irlaser_tan",
                        "BWA3_acc_LLM01_irlaser"]
    ]],
    ["ammo",        [ [ 2, "BWA3_120Rnd_762x51_soft" ]              /* 3 Magazine inkl. dem in der Waffe */
    ]]
  ]]
];

/*   Das ist das standard-loadout, von dem alle anderen loadouts abgeleitet oder angepasst werden.
  Die Bewaffung und Munition ist bestandteil der Waffe und wird darüber gesteuert.
*/

private _default_loadout=createHashMapFromArray [
  /*                      tree                 grass                 sand                 snow          */
  [ "goggles",            ["G_Combat_Goggles_tna_F",        "G_Combat_Goggles_tna_F",         "G_Combat",                       "G_Combat"]],
  [ "helmet",             ["BWA3_OpsCore_FastMT_SOF_Fleck", "BWA3_OpsCore_FastMT_SOF_Multi",  "BWA3_OpsCore_FastMT_SOF_Tropen", "TBW_Helm2_Schnee"]],
  [ "uniform",            ["BWA3_Uniform_Crye_G3_Fleck",    "BWA3_Uniform_Crye_G3_Multi",     "BWA3_Uniform_Crye_G3_Tropen",    "PzBrig17_Uniform_Snow" ]],
  [ "vest",               ["BWA3_Vest_Fleck",               "BWA3_Vest_Multi",                "BWA3_Vest_Tropen",               "TBW_Weste_Schnee"]],
  [ "backpack",           ["BWA3_AssaultPack_Fleck",        "BWA3_AssaultPack_Multi",         "BWA3_AssaultPack_Tropen",        "TBW_AssaultPack_Schnee"]],
  [ "nightvision",        "dsk_nsv"],
  
  [ "handgun",            _handgun_P12 ],
  [ "primary",            _primary_G38 ],
  [ "secondary",          nil],
  [ "binocular",          nil],
  [ "tools",              [ "ItemMap", "ItemCompass", "TFAR_microdagr", "TFAR_rf7800str", "ItemMicroDAGR" ] ],

  [ "uniform_content",    [ [ 1, "ACE_EarPlugs" ],
                            [ 1, "ACE_Banana" ], 
                            [ 1, "acex_intelitems_notepad"],
                            [ 1, "ACE_Flashlight_KSF1" ],
                            [ 3, "ACE_CableTie" ],
                            [ 2, "ACE_morphine" ],
                            [ 1, "ACE_tourniquet" ],
                            [ 2, "ACE_morphine" ],
                            [15, "ACE_fieldDressing" ]
                          ]
  ],[ "vest_content",     [ [ 1, "ACE_EntrenchingTool" ],
                            [ 1, "ACE_SpraypaintRed" ],
                            [ 3, "BWA3_DM51A1" ],
                            [ 1, "BWA3_DM32_Yellow" ],
                            [ 1, "BWA3_DM32_Orange" ],
                            [ 1, "BWA3_DM25" ]
                          ]
  ],[ "backpack_content", [ [ 12, "ACE_fieldDressing" ],
                            [  3, "ACE_morphine" ]
  ]]
];


/*   ab hier kommen die Anpassungen der Loadouts an die Klassen:
  Das heißt, die Anpassung von Weste (aussehen) oder das hinzufügen von Items
  zu Weste oder Rucksack, tausch der Waffen usw. Jeder Funktion erhält als
  Ausgangspunkt das Loadout "_default_loadout" und kann sich daran anpassen.
*/

fcn_Truppfueher={
  params ["_in_loadout"];
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G38C ];                                   /* Mit der Kompaktversion ersetzen */
  _loadout set ["tools", [ "ItemMap", "ItemCompass", "ItemWatch", "TFAR_anprc152", "ItemAndroid"]];      /* leicht andere Tools */  
  _loadout set ["binocular", "ACE_Vector"];                                  /* VectorIV Fernglas */
  _loadout set ["goggles", ["G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Balaclava_Tropentarn"]];
  /* ok, Nerd-Variante: Wir holen uns das Array des Rucksackinhalts, hängen das HunterIR an und schreiben es zurück. */
  private _bp=_loadout get "backpack_content";
  _bp append [[ 1, "ACE_HuntIR_monitor"]];

  _loadout set ["backpack_content", _bp];
  /* weil wir es können, erstzen wir die Weste JPC Leader */
  _loadout set [ "vest", ["BWA3_Vest_JPC_Leader_Fleck", "BWA3_Vest_JPC_Leader_Multi", "BWA3_Vest_JPC_Leader_Tropen", "TBW_Weste_Schnee"]];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_TruppfueherFunk={
  params ["_in_loadout"];
  /* ist erstmal das gleiche wie der Truppführer */
  private _loadout = [_in_loadout] call fcn_Truppfueher;
  _loadout set ["backpack", ["TFAR_rt1523g_bwmod", "TFAR_rt1523g_bwmod", "TFAR_rt1523g", "TFAR_rt1523g"]];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Gruppenfueher={
  params ["_in_loadout"];
  /* ist erstmal das gleiche wie der Truppführer */
  private _loadout = [_in_loadout] call fcn_Truppfueher;

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_GruppenfueherFunk={
  params ["_in_loadout"];
  /* ist erstmal das gleiche wie der TruppführerFunk */
  private _loadout = [_in_loadout] call fcn_TruppfueherFunk;

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Sanitaeter={
  params ["_in_loadout"];
  private _loadout = _in_loadout;
  _loadout set ["goggles", ["BWA3_G_Combat_clear", "BWA3_G_Combat_clear", "BWA3_G_Combat_black", "BWA3_G_Combat_black"]];
  _loadout set ["primary", _primary_G38C ];  /* Mit der Kompaktversion ersetzen */
  _loadout set ["backpack", ["BWA3_AssaultPack_Fleck_Medic", "BWA3_AssaultPack_Multi_Medic", "BWA3_AssaultPack_Tropen_Medic", "TBW_AssaultPack_Schnee"]];                                /* VectorIV Fernglas */
  _loadout set ["vest", ["BWA3_Vest_Medic_Fleck", "BWA3_Vest_Medic_Multi", "BWA3_Vest_Medic_Tropen", "TBW_Weste_Schnee"]];

  /* so richtig viel medic zeug */
  private _bp=[  [ 42, "ACE_fieldDressing" ],
          [ 12, "ACE_morphine" ],
          [ 12, "ACE_epinephrine" ],
          [ 12, "ACE_adenosine" ],
          [  8, "ACE_splint" ],
          [  2, "ACE_tourniquet" ],
          [ 12, "ACE_salineIV_250" ],
          [  1, "ACE_personalAidKit" ]
  ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Aufklaerer={
  params ["_in_loadout"];
  //systemChat "Aufklärer";
  private _loadout = _in_loadout;
  _loadout set ["goggles", ["G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Balaclava_Tropentarn"]];
  _loadout set ["primary", _primary_G38C ];  /* Mit der Kompaktversion ersetzen */
  _loadout set ["vest", ["BWA3_Vest_JPC_Radioman_Fleck", "BWA3_Vest_JPC_Radioman_Multi", "BWA3_Vest_JPC_Radioman_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["binocular", "ACE_Vector"];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 1, "ACE_wirecutter"],
        [ 1, "ACE_SpottingScope"]];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Funker={
  params ["_in_loadout"];
  //systemChat "Funker";
  private _loadout = _in_loadout;
  _loadout set ["goggles", ["BWA3_G_Combat_clear", "BWA3_G_Combat_clear", "BWA3_G_Combat_black", "BWA3_G_Combat_black"]];
  _loadout set ["primary", _primary_G38C ];                                   /* Mit der Kompaktversion ersetzen */
  _loadout set ["vest", ["BWA3_Vest_JPC_Radioman_Fleck", "BWA3_Vest_JPC_Radioman_Multi", "BWA3_Vest_JPC_Radioman_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["backpack", ["tf_mr3000_bwmod", "tf_mr3000_bwmod_multicam", "tf_mr3000_bwmod_tropen", "tf_mr3000_bwmod_tropen"]];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_UAVOP_light={
  params ["_in_loadout"];
  //systemChat "UAV Operator - Leicht";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G38C ];                                   /* Mit der Kompaktversion ersetzen */
  _loadout set ["goggles", ["BWA3_G_Combat_clear", "BWA3_G_Combat_clear", "BWA3_G_Combat_black", "BWA3_G_Combat_black"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 1, "B_UavTerminal"],
        [ 3, "ACE_UAVBattery"]];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_UAVOP_heavy={
  params ["_in_loadout"];
  //systemChat "UAV Operator - Schwer";
  private _loadout = _in_loadout;
  _loadout set ["goggles", ["BWA3_G_Combat_clear", "BWA3_G_Combat_clear", "BWA3_G_Combat_black", "BWA3_G_Combat_black"]];
  _loadout set ["primary", _primary_G38C ];                                   /* Mit der Kompaktversion ersetzen */
  _loadout set ["backpack", "B_UAV_01_backpack_F"];
  
  private _bp=_loadout get "vest_content";
  _bp append [[ 1, "B_UavTerminal"],
        [ 2, "ACE_UAVBattery"]];
  _loadout set ["vest_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Pionier_Spreng={
  params ["_in_loadout"];
  //systemChat "Pionier";
  private _loadout = _in_loadout;
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["goggles", ["G_Balaclava_Flecktarn", "G_Balaclava_Flecktarn", "G_Balaclava_Tropentarn", "G_Balaclava_TI_G_blk_F"]];
  private _bp=_loadout get "backpack_content";
  _bp append [[ 1, "ACE_wirecutter"],
        [ 1, "ACE_DefusalKit"],
        [ 1, "ACE_VMH3"],
        [ 3, "DemoCharge_Remote_Mag"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Pionier_Mine={
  params ["_in_loadout"];
  //systemChat "Pionier";
  private _loadout = _in_loadout;
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["goggles", ["G_Balaclava_Flecktarn", "G_Balaclava_Flecktarn", "G_Balaclava_Tropentarn", "G_Balaclava_TI_G_blk_F"]];
  private _bp=_loadout get "backpack_content";
  _bp append [[ 1, "ACE_wirecutter"],
        [ 1, "ACE_DefusalKit"],
        [ 1, "ACE_VMH3"],
        [ 3, "APERSBoundingMine_Range_Mag"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Schuetze_Leicht={
  params ["_in_loadout"];
  //systemChat "Schütze";
  private _loadout = _in_loadout;
  _loadout set ["vest", ["BWA3_Vest_Rifleman_Fleck", "BWA3_Vest_Rifleman_Multi", "BWA3_Vest_Rifleman_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 12, "__extra_primary_ammo" ],
        [ 3, "ACE_WaterBottle"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_SDM_Uniform={
  params ["_in_loadout"];
  //systemChat "Gruppenscharfschütze";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G28 ];
  _loadout set ["vest", ["BWA3_Vest_Marksman_Fleck", "BWA3_Vest_Marksman_Multi", "BWA3_Vest_Marksman_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["goggles", ["G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Balaclava_Tropentarn"]];
  private _bp=_loadout get "backpack_content";
  _bp append [  [ 6, "__extra_primary_ammo"] ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_SDM_Ghillie={
  params ["_in_loadout"];
  //systemChat "Gruppenscharfschütze mit Ghillie";
  private _loadout = [_in_loadout] call fcn_SDM_Uniform;
  _loadout set ["uniform", ["BWA3_Uniform2_Ghillie_Fleck", "BWA3_Uniform2_Ghillie_Multi", "BWA3_Uniform2_Ghillie_Tropen", "PzBrig17_Ghillie_Snow"]];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Praezisionsschuetze_G29={
  params ["_in_loadout"];
  //systemChat "Gruppenscharfschütze";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G29 ];
  _loadout set ["uniform", ["BWA3_Uniform2_Ghillie_Fleck", "BWA3_Uniform2_Ghillie_Multi", "BWA3_Uniform2_Ghillie_Tropen", "PzBrig17_Ghillie_Snow"]];
  _loadout set ["vest", ["BWA3_Vest_Marksman_Fleck", "BWA3_Vest_Marksman_Multi", "BWA3_Vest_Marksman_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["goggles", ["G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Balaclava_Tropentarn"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [  [ 5, "__extra_primary_ammo"] ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Praezisionsschuetze_G82={
  params ["_in_loadout"];
  //systemChat "Gruppenscharfschütze";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G82 ];
  _loadout set ["uniform", ["BWA3_Uniform2_Ghillie_Fleck", "BWA3_Uniform2_Ghillie_Multi", "BWA3_Uniform2_Ghillie_Tropen", "PzBrig17_Ghillie_Snow"]];
  _loadout set ["vest", ["BWA3_Vest_Marksman_Fleck", "BWA3_Vest_Marksman_Multi", "BWA3_Vest_Marksman_Tropen", "TBW_Weste_Schnee"]];
  _loadout set ["goggles", ["G_Tactical_Clear", "G_Tactical_Clear", "G_Tactical_Black", "G_Balaclava_Tropentarn"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [  [ 5, "__extra_primary_ammo"] ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Schuetze_MG4={
  params ["_in_loadout"];
  //systemChat "Schütze MG4";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_MG4 ];
  _loadout set ["vest", ["BWA3_Vest_Rifleman_Fleck", "BWA3_Vest_Rifleman_Multi", "BWA3_Vest_Rifleman_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "__extra_primary_ammo" ],
        [ 3, "ACE_WaterBottle"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Schuetze_MG5={
  params ["_in_loadout"];
  //systemChat "Schütze MG5";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_MG5 ];
  _loadout set ["vest", ["BWA3_Vest_Rifleman_Fleck", "BWA3_Vest_Rifleman_Multi", "BWA3_Vest_Rifleman_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "__extra_primary_ammo" ],
        [ 3, "ACE_WaterBottle"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Grenadier_AGL={
  params ["_in_loadout"];
  //systemChat "Grenadier AGL";
  private _loadout = _in_loadout;
  _loadout set ["primary", _primary_G38AGL ];
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "__extra_primary_ammo" ],
        [ 6, "ACE_HuntIR_M203"],
        [ 6, "1Rnd_Smoke_Grenade_shell"],
        [12, "1Rnd_HE_Grenade_shell"]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Grenadier_PZ3={
  params ["_in_loadout"];
  //systemChat "Grenadier PZ3";
  private _loadout = _in_loadout;
  _loadout set ["secondary", createHashMapFromArray [
    ["type", "BWA3_PzF3_Tandem_Loaded"],
    ["attachments", []],
    ["ammo", []]
  ] ];
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "__extra_primary_ammo" ]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Grenadier_Leuchtbuechse={
  params ["_in_loadout"];
  //systemChat "Grenadier Leuchtbuechse";
  private _loadout = _in_loadout;
  _loadout set ["secondary", createHashMapFromArray [
    ["type", "BWA3_CarlGustav"],
    ["attachments", ["BWA3_optic_CarlGustav"]],
    ["ammo", [[1, "BWA3_CarlGustav_HEAT"]]]
  ] ];
  _loadout set ["backpack", ["BWA3_Kitbag_Fleck", "BWA3_Kitbag_Multi", "BWA3_Kitbag_Tropen", "BW_Backpack_Tropentarn"]];
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "BWA3_CarlGustav_HEAT" ]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Grenadier_Fliegerfaust2={
  params ["_in_loadout"];
  //systemChat "Grenadier Fliegerfaust";
  private _loadout = _in_loadout;
  _loadout set ["secondary", createHashMapFromArray [
    ["type", "BWA3_Fliegerfaust"],
    ["attachments", []],
    ["ammo", [[1, "BWA3_Fliegerfaust_Mag"]]]
  ] ];
  _loadout set ["backpack", ["BWA3_Kitbag_Fleck", "BWA3_Kitbag_Multi", "BWA3_Kitbag_Tropen", "BW_Backpack_Tropentarn"]];
  _loadout set ["vest", ["BWA3_Vest_Grenadier_Fleck", "BWA3_Vest_Grenadier_Multi", "BWA3_Vest_Grenadier_Tropen", "TBW_Weste_Schnee"]];
  
  private _bp=_loadout get "backpack_content";
  _bp append [[ 2, "BWA3_Fliegerfaust_Mag" ]
        ];

  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = _in_loadout;

  _loadout set ["backpack", ["BWA3_Kitbag_Fleck", "BWA3_Kitbag_Multi", "BWA3_Kitbag_Tropen", "BW_Backpack_Tropentarn"]];
  _loadout set ["vest", ["BWA3_Vest_Rifleman_Fleck", "BWA3_Vest_Rifleman_Multi", "BWA3_Vest_Rifleman_Tropen", "TBW_Weste_Schnee"]];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger_Allgemein={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = [_in_loadout] call fcn_Munitionstraeger;

  private _bp=_loadout get "backpack_content";
  _bp append [[ 16, "BWA3_30Rnd_556x45_G36_AP" ],
        [ 42, "ACE_fieldDressing" ],
        [ 12, "ACE_morphine" ],
        [ 12, "ACE_epinephrine" ],
        [ 12, "ACE_adenosine" ],
        [  8, "ACE_splint" ],
        [  6, "ACE_tourniquet" ],
        [ 12, "ACE_salineIV_250" ]
        ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger_MG4={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = [_in_loadout] call fcn_Munitionstraeger;

  private _bp=_loadout get "backpack_content";
  _bp append [[ 12, "BWA3_30Rnd_556x45_G36_AP" ],
        [ 6, "BWA3_200Rnd_556x45" ]
        ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger_MG5={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = [_in_loadout] call fcn_Munitionstraeger;

  private _bp=_loadout get "backpack_content";
  _bp append [[ 12, "BWA3_30Rnd_556x45_G36_AP" ],
        [ 6, "BWA3_120Rnd_762x51_soft" ]
        ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger_CG={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = [_in_loadout] call fcn_Munitionstraeger;

  private _bp=_loadout get "backpack_content";
  _bp append [[ 3, "BWA3_CarlGustav_HEAT" ],
        [ 6, "BWA3_30Rnd_556x45_G36_AP" ]
        ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Munitionstraeger_FL={
  params ["_in_loadout"];
  //systemChat "Munitionsträger";
  private _loadout = [_in_loadout] call fcn_Munitionstraeger;

  private _bp=_loadout get "backpack_content";
  _bp append [[ 2, "BWA3_Fliegerfaust_Mag" ],
        [ 6, "BWA3_30Rnd_556x45_G36_AP" ]
        ];
  _loadout set ["backpack_content", _bp];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Pilot={
  params ["_in_loadout"];
  //systemChat "Pilot";
  private _loadout = _in_loadout;
  _loadout set ["primary", createHashMapFromArray [
    ["type", "BWA3_MP7"],
    ["attachments", ["BWA3_acc_VarioRay_irlaser_black", "BWA3_optic_MicroT2"]],
    ["ammo", [[6, "BWA3_40Rnd_46x30_MP7"]]]
  ] ];

  _loadout set ["helmet", "H_PilotHelmetHeli_B"];
  _loadout set ["goggles", nil];
  _loadout set ["uniform", "BWA3_Uniform_Helipilot"];
  _loadout set ["backpack", nil];
  _loadout set ["vest", "V_PlateCarrier1_blk"];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Panzerfahrer={
  params ["_in_loadout"];
  //systemChat "Panzerfahrer";
  private _loadout = _in_loadout;
  _loadout set ["primary", createHashMapFromArray [
    ["type", "BWA3_MP7"],
    ["attachments", ["BWA3_acc_VarioRay_irlaser_black", "BWA3_optic_MicroT2"]],
    ["ammo", [[6, "BWA3_40Rnd_46x30_MP7"]]]
  ] ];

  _loadout set ["helmet", "H_PilotHelmetHeli_B"];
  _loadout set ["goggles", "G_Combat_Goggles_tna_F"];
  _loadout set ["uniform", "BWA3_Uniform_Crew_Fleck"];
  _loadout set ["backpack", nil];
  _loadout set ["vest", "V_PlateCarrier1_blk"];

  _loadout;  /* Rückgabe des Loadouts */
};

fcn_Stabsuniform={
  params ["_in_loadout"];
  //systemChat "Stabsuniform";
  private _loadout = _in_loadout;
  _loadout set ["primary", nil];
  _loadout set ["helmet", ["TBW_Barett_KSK", "BWA3_OpsCore_FastMT_SOF_Multi", "TBW_booniehat_hs_Tropen", "H_Watchcap_khk"]];
  _loadout set ["goggles", "BWA3_G_Combat_black"];
  _loadout set ["backpack", nil];
  _loadout set ["vest", ["BWA3_Vest_Fleck", "BWA3_Vest_Multi", "BWA3_Vest_Tropen", "BWA3_Vest_Tropen"]];

  _loadout;  /* Rückgabe des Loadouts */
};

/* Ab hier wird das eigentliche Klassenmenü aufgebaut.

*/

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
      ["Aufklärer", fcn_Aufklaerer],
      ["Funker", fcn_Funker],
      ["UAV Operator", createHashMapFromArray [
        [ "Rucksack", fcn_UAVOP_light],
        [ "UAV Rucksack", fcn_UAVOP_heavy]
      ]]
    ]
  ],
  [ "Infantrie", createHashMapFromArray [
      ["Pionier", createHashMapFromArray [
        [ "Sprengstoff", fcn_Pionier_Spreng],
        [ "Anti Personen Minen", fcn_Pionier_Mine]
      ]],
      ["Schütze", fcn_Schuetze_Leicht],
      ["Gruppenscharfschütze", createHashMapFromArray [
        [ "Ghillie", fcn_SDM_Ghillie],
        [ "Uniform", fcn_SDM_Uniform]
      ]],
      ["Präzisionsschütze", createHashMapFromArray [
        [ "G29", fcn_Praezisionsschuetze_G29],
        [ "G82", fcn_Praezisionsschuetze_G82]
      ]],
      ["Munitionsträger", createHashMapFromArray [
        [ "für Trupp", fcn_Munitionstraeger_Allgemein],
        [ "für MG4", fcn_Munitionstraeger_MG4],
        [ "für MG5", fcn_Munitionstraeger_MG5],
        [ "für Leuchtbüchse", fcn_Munitionstraeger_CG],
        [ "für Fliegerfaust", fcn_Munitionstraeger_FL]
      ]]
    ]
  ],
  [ "Schwere Infantrie", createHashMapFromArray [
      ["Schütze MG4", fcn_Schuetze_MG4],
      ["Schütze MG5", fcn_Schuetze_MG5],
      ["Grenadier AGL", fcn_Grenadier_AGL],
      ["Grenadier PZ3", fcn_Grenadier_PZ3],
      ["Grenadier Leuchtbüchse", fcn_Grenadier_Leuchtbuechse],
      ["Grenadier Fliegerfaust 2", fcn_Grenadier_Fliegerfaust2]
    ]
  ],
  [ "Sonderausrüstung", createHashMapFromArray [
      ["Stabsuniform", fcn_Stabsuniform ],
      ["Pilot", fcn_Pilot],
      ["Panzerbesatzung", fcn_Panzerfahrer]
    ]
  ],
  [ "Tarnfarbe", createHashMapFromArray [
      ["Flecktarn", [camouflage_change, "tree"]],
      ["Multitarn", [camouflage_change, "gras"]],
      ["Tropentarn", [camouflage_change, "sand"]],
      ["Schneetarn", [camouflage_change, "snow"]]
    ]
  ],
  [ "Operationsmodus", createHashMapFromArray [
      ["Verdeckte Operation", [special_change, "special"]],
      ["Reguläre Operation", [special_change, "regular"]]
    ]
  ]
  
];

[_object, true] call ace_arsenal_fnc_initBox;

[ _object, _unit_classes, _default_loadout ] call fcn_loadout_menu;
