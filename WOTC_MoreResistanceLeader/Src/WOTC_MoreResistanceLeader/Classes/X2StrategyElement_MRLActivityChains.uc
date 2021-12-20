class X2StrategyElement_MRLActivityChains extends X2StrategyElement_DefaultActivityChains config(MRL);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Activites;	
	
	Activites.AddItem(CreateJailbreakMRLTemplate());		

	return Activites;
}

static function X2DataTemplate CreateJailbreakMRLTemplate()
{
	local X2ActivityChainTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ActivityChainTemplate', Template, 'ActivityChain_JailbreakMRLSoldier');
	
	Template.ChooseFaction = ChooseMetFaction;
	Template.ChooseRegions = ChooseRandomContactedRegion;
	Template.SpawnInDeck = true;
	Template.NumInDeck = 3;
	Template.DeckReq = IsMRLChainAvailable;
    Template.ChainRewards.AddItem('Reward_ResistanceLeader');

	Template.Stages.AddItem(ConstructPresetStage('Activity_PreparePersonnel_MRL'));
	Template.Stages.AddItem(ConstructRandomStage('eActivityType_Infiltration', 'Tag_Personnel',,, 'Reward_ChainProxy'));
	
	Template.GetNarrativeObjective = GetStaffObjective;

	return Template;
}

static function bool IsMRLChainAvailable(XComGameState NewGameState)
{
	local RescueClassData RescueClass;

    // Only 1 at a time, else we can spawn one while the previous is still in progress, thus violating the count rules
	if (DoesActiveChainExist('ActivityChain_JailbreakMRLSoldier', NewGameState)) return false;

    // If we getting blank then we should not trigger the chain
	RescueClass = class'X2DownloadableContentInfo_WOTC_MoreResistanceLeader'.static.GetConfigEntry();
    if (RescueClass.ClassName == '') return false;
    
    return true;
}