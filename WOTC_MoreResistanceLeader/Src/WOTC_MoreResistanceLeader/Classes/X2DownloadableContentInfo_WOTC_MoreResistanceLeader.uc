class X2DownloadableContentInfo_WOTC_MoreResistanceLeader extends X2DownloadableContentInfo;

struct RescueClassData
{
	var name ClassName;
	var int Limit;
	var ECombatIntelligence MinComInt;

	structdefaultproperties
	{
		MinComInt = eComInt_Standard;
	}
};

var config (MRL) array<RescueClassData> RescueClasses;

static function name DetermineSoldierClass()
{
	local RescueClassData RescueClass;
	local XComGameState_Unit Unit;
	local StateObjectReference UnitRef;
	local XComGameState_HeadquartersXCom XComHQ;
	local int iCount;

	XComHQ = `XCOMHQ;
	foreach default.RescueClasses(RescueClass)
	{
		iCount = 0; // Init
        foreach XComHQ.Crew(UnitRef)
        {
            Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
            if (Unit != none && Unit.IsSoldier() && Unit.GetSoldierClassTemplate().DataName == RescueClass.ClassName)
            {
                iCount++;
            }
        }

        if (iCount < RescueClass.Limit)
        {
            return RescueClass.ClassName;
        }
	}

	return '';
}

static function ECombatIntelligence GetMinComInt(name SoldierClassName)
{
	local int i;

	i = default.RescueClasses.Find('ClassName', SoldierClassName);

	if (i != INDEX_NONE)
	{
		return default.RescueClasses[i].MinComInt;
	}

	return eComInt_Standard;
}