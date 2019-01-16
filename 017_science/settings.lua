data:extend(
{
    {
        type = "bool-setting",
        name = "017-old-science",
        setting_type = "startup",
        default_value = false,
		order = "npc-a"
    },
	{
        type = "bool-setting",
        name = "017-pack-type-rebalancing",
        setting_type = "startup",
        default_value = true,
		order = "npc-b"
    },
	{
        type = "bool-setting",
        name = "017-techtree",
        setting_type = "startup",
        default_value = true,
		order = "npc-c"
    },
	{
        type = "int-setting",
        name = "017-nuclear-reprocessing-discount",
        setting_type = "startup",
		minimum_value = 0,
		maximum_value = 1400,
        default_value = 1000,
		order = "npc-d"
    },
    {
        type = "bool-setting",
        name = "017-recipes-changes",
        setting_type = "startup",
        default_value = true,
		order = "npc-e"
    },
	{
        type = "bool-setting",
        name = "017-lds",
        setting_type = "startup",
        default_value = true,
		order = "npc-f"
    },
	{
        type = "int-setting",
        name = "017-lds-num",
        setting_type = "startup",
		minimum_value = 1,
		maximum_value = 32,
        default_value = 5,
		order = "npc-g"
    },
    {
        type = "bool-setting",
        name = "017-drill",
        setting_type = "startup",
        default_value = true,
		order = "npc-h"
    },
    {
        type = "bool-setting",
        name = "017-smelting",
        setting_type = "startup",
        default_value = true,
		order = "npc-i"
    },
    {
        type = "bool-setting",
        name = "017-assem-lim",
        setting_type = "startup",
        default_value = true,
		order = "npc-j"
    },
	{
        type = "bool-setting",
        name = "017-durability",
        setting_type = "startup",
        default_value = true,
		order = "npc-k"
    },
    {
        type = "bool-setting",
        name = "017-axe",
        setting_type = "startup",
        default_value = true,
		order = "npc-l"
    },	
	{
        type = "bool-setting",
        name = "017-equipment",
        setting_type = "startup",
        default_value = true,
		order = "npc-m"
    },
	{
        type = "bool-setting",
        name = "017-rocket-victory",
        setting_type = "startup",
        default_value = true,
		order = "npc-me"
    },
	{
        type = "bool-setting",
        name = "017-tank-gun-nerf",
        setting_type = "startup",
        default_value = true,
		order = "npc-mf"
    },
	--costs
	{
        type = "int-setting",
        name = "017-green-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 50,
		order = "npc-na"
    },
	{
        type = "int-setting",
        name = "017-chem-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 200,
		order = "npc-nb"
    },
	{
        type = "int-setting",
        name = "017-purple-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 250,
		order = "npc-nc"
    },
	{
        type = "int-setting",
        name = "017-gold-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 250,
		order = "npc-nd"
    },
	{
        type = "int-setting",
        name = "017-nasa-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 5000,
		order = "npc-ne"
    },
	{
        type = "int-setting",
        name = "017-lubricant-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 100,
		order = "npc-nf"
    },
	{
        type = "int-setting",
        name = "017-rocket-fuel-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 100,
		order = "npc-ng"
    },
	{
        type = "int-setting",
        name = "017-rocket-structure-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 200,
		order = "npc-nh"
    },
	{
        type = "int-setting",
        name = "017-rocket-control-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 250,
		order = "npc-ni"
    },
	{
        type = "int-setting",
        name = "017-uranium-enrichment-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 500,
		order = "npc-nj"
    },
	{
        type = "int-setting",
        name = "017-nuclear-power-cost",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 500,
		order = "npc-nk"
    },
	--energies
	{
        type = "int-setting",
        name = "017-green-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 5,
		order = "npc-oa"
    },
	{
        type = "int-setting",
        name = "017-chem-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 15,
		order = "npc-ob"
    },
	{
        type = "int-setting",
        name = "017-purple-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-oc"
    },
	{
        type = "int-setting",
        name = "017-gold-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-od"
    },
	{
        type = "int-setting",
        name = "017-nasa-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 60,
		order = "npc-oe"
    },
	{
        type = "int-setting",
        name = "017-lubricant-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-of"
    },
	{
        type = "int-setting",
        name = "017-rocket-fuel-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-og"
    },
	{
        type = "int-setting",
        name = "017-rocket-structure-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-oh"
    },
	{
        type = "int-setting",
        name = "017-rocket-control-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-oi"
    },
	{
        type = "int-setting",
        name = "017-uranium-enrichment-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-oj"
    },
	{
        type = "int-setting",
        name = "017-nuclear-power-energy",
        setting_type = "startup",
		minimum_value = 0,
        default_value = 30,
		order = "npc-ok"
    }
})