Gijutsu = LibStub("AceAddon-3.0"):NewAddon("Gijutsu")
Gijutsu.version = GetAddOnMetadata("Gijutsu", "Version");

local defaults = {
    profile = {
        minimap = {
            hide = false,
            minimapPos = 140.35,
        },
    },
};

local spellList = {
    3908, -- Tailoring
    701358, -- Smithing
    13262, -- Dismantling
    2656, -- Chakra Infusion
    3413, -- Cooking
    818, -- Campfire
    7731, -- Fishing
};

function Gijutsu:OnInitialize()
    local GijutsuIconDB = LibStub("LibDataBroker-1.1"):NewDataObject("Gijutsu", {
        type = "data source",
        text = "Gijutsu",
        icon = "Interface\\Icons\\GreenScroll",
        OnClick = function() 
            Gijutsu:ToggleFrame();
        end,
        OnTooltipShow = function(tooltip)
			tooltip:AddLine("|c00e6cc80Gijutsu no Jutsu|r");
			tooltip:AddLine("|cFFFF8040Click|r: Open/Close menu with spells.");
		end,
    })
    self.db = LibStub("AceDB-3.0"):New("GijutsuDB", defaults);
    local icon = LibStub("LibDBIcon-1.0");
    icon:Register("GijutsuIcon", GijutsuIconDB, GijutsuDB);
end

function Gijutsu:Cast(button)
    CastSpellByID(button.spellId);
end

function Gijutsu:LoadSpellButton(button)
    local id = button:GetID();
    button.spellId = spellList[id];
    local name, _, spell_icon = GetSpellInfo(button.spellId);
    button.spellName = name;
    _G["GijutsuFrameSpellButton"..id.."Icon"]:SetTexture(spell_icon);
    _G["GijutsuFrameSpellButton"..id.."Name"]:SetText(name);
    button:RegisterForDrag("LeftButton");
    button:SetAttribute("type", "spell");
    button:SetAttribute("spell", name);
end

function Gijutsu:ToggleFrame()
    if (GijutsuFrame:IsShown()) then
        GijutsuFrame:Hide();
    else
        GijutsuFrame:Show();
    end
end