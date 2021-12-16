class X2StrategyElement_MRLActivities extends X2StrategyElement_DefaultActivities;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	CreatePreparePersonnel_MRL(Templates);	

	return Templates;
}

//////////////////////
/// Covert Actions ///
//////////////////////

static function CreatePreparePersonnel_MRL (out array<X2DataTemplate> Templates)
{
	local X2ActivityTemplate_CovertAction Activity;
	local X2CovertActionTemplate CovertAction;
	
	`CREATE_X2TEMPLATE(class'X2ActivityTemplate_CovertAction', Activity, 'Activity_PreparePersonnel_MRL');
	CovertAction = CreateStandardActivityCA("PreparePersonnel_MRL", "CovertAction");

	CovertAction.Slots.AddItem(class'X2Helper_Infiltration'.static.CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	CovertAction.Slots.AddItem(class'X2Helper_Infiltration'.static.CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	CovertAction.OptionalCosts.AddItem(class'X2Helper_Infiltration'.static.CreateOptionalCostSlot('Supplies', 25));

	CovertAction.Risks.AddItem('CovertActionRisk_SoldierWounded');
	CovertAction.Rewards.AddItem('Reward_Progress');

	Activity.CovertActionName = CovertAction.DataName;
	Activity.AvailableSound = "Geoscape_NewResistOpsMissions";

	Templates.AddItem(CovertAction);
	Templates.AddItem(Activity);
}