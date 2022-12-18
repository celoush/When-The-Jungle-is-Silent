
_grp = units v1;
{_x moveInCargo heli_1} forEach _grp;

diary = player createDiaryRecord ["Diary", [localize "STR_CELO_DiaryName",  localize "STR_CELO_DiaryDescription"]];

"colorCorrections" ppEffectAdjust [1, 0.99, -0.02, [0.8, 0.8, 1.0, 0.05], [0.5,0.8, 0.6, 0.65], [0.2, 0.5, 0.1, 0.0]];
"colorCorrections" ppEffectCommit 0;   
"colorCorrections" ppEffectEnable true; 

setDate [1968,systemTime#1,systemTime#2,((systemTime#3%11) max 7),systemTime#4];
setviewdistance 1750; 
0 setFog 0.7;
0 setOvercast 0; 
0 setRain 0;
forceWeatherChange;

0 spawn {
	300 setOvercast 0.5
};


0 spawn {

	0 fadeSound 0;
	0 fadeMusic 0;

	titleCut["","BLACK IN",999999];
	[0, 0, true, true] spawn BIS_fnc_cinemaBorder;

	0 spawn {	
		sleep 10;
		titleCut["","BLACK IN",3];	
		10 fadeSound 1;
		10 fadeMusic 1;
		sleep 10;
		[1, 3, true, true] spawn BIS_fnc_cinemaBorder;
	};

	sleep 1;

	[
      [
           [format ["%4: %1.%2.%3", systemTime#2,systemTime#1,1968,localize "STR_CELO_Date"],"<t align = 'left' shadow = '1' size = '1' font='tt2020style_e_vn_bold'>%1</t><br />"],
           [format ["%3: %1:%2", ((systemTime#3%11) max 7),systemTime#4,localize "STR_CELO_Time"],"<t align = 'left' shadow = '1' size = '1' font='tt2020style_e_vn_bold'>%1</t><br />"],
           [format ["%1: %2",localize "STR_CELO_Position",text nearestLocation [position player, "NameVillage"]],"<t align = 'left' shadow = '1' size = '1' font='tt2020style_e_vn_bold'>%1</t><br />"],
           [format["%1: %2",localize "STR_CELO_Mission",localize "STR_CELO_MissionType"], "<t align = 'left' shadow = '1' size = '1' font='tt2020style_e_vn_bold'>%1</t><br />"],
           [" "],
           [format["%1: %2",localize "STR_CELO_Unit",localize "STR_CELO_UnitName"], "<t align = 'left' shadow = '1' size = '1' font='tt2020style_e_vn_bold'>%1</t>"]
      ]
	] spawn vn_ms_fnc_sfx_typeText;

	sleep 17;

	[
		parseText format["<t font='PuristaBold' size='1.2'>%1<br />%2</t><br /><t font='PuristaBold' size='2'>%3</t>",
			localize "STR_CELO_Created",
			localize "STR_CELO_By",
			localize "STR_CELO_CreatorName"
		], true, 10, 6, 1.7, 0
	] spawn BIS_fnc_textTiles;


};


CELO_fnc_create_evidence_for_us = {
	private _evidence = _this#0;
	_evidence setVariable ["RscAttributeDiaryRecord_texture","images\evidence.jpg",true];
	[_evidence,"RscAttributeDiaryRecord",[_this#1,_this#2]] call BIS_fnc_setServerVariable;
	_evidence setVariable ["recipients", west, true];
	_evidence setVariable ["RscAttributeOwners", [west], true];
	[_evidence,"intelObjectFound",_this#3] call BIS_fnc_addScriptedEventHandler;
};

evidence1_found = false;

if (isServer) then {
	[evidence_1,localize "STR_CELO_Found_enemy_intel",localize "STR_CELO_Planned_position_of_enemies",{evidence1_found = true;publicVariable "evidence1_found";}] call CELO_fnc_create_evidence_for_us;
};