AddCSLuaFile()

--[[
-----------------------------------------------------------------------------------------------------
Subcategories
-----------------------------------------------------------------------------------------------------
]]
-- list.Set("WeaponTreeIcons", "EFT", "logo16/logo_eftmedkit_16.png")
list.Set("WeaponTreeIcons", "EFT.Drugs", "logo16/logo_eftdrug_16.png")
list.Set("WeaponTreeIcons", "EFT.Stimulants", "logo16/logo_eftstim_16.png")
list.Set("WeaponTreeIcons", "EFT.Medkits", "logo16/logo_eftmedkit_16.png")
list.Set("WeaponTreeIcons", "EFT.Injury Treatment", "logo16/logo_eftinjury_16.png")

list.Set("WeaponTreeThumbnails", "EFT.Drugs", "entities/weapon_eft_augmentin.png")
list.Set("WeaponTreeThumbnails", "EFT.Stimulants", "entities/weapon_eft_injectoradrenaline.png")
list.Set("WeaponTreeThumbnails", "EFT.Medkits", "entities/weapon_eft_afak.png")
list.Set("WeaponTreeThumbnails", "EFT.Injury Treatment", "entities/weapon_eft_surgicalkit.png")

--[[
-----------------------------------------------------------------------------------------------------
Particle Cache
-----------------------------------------------------------------------------------------------------
]]
-- if CLIENT then
   -- game.AddParticles("particles/ep2/antlion_gib_02.pcf")
   
   -- PrecacheParticleSystem("antlion_gib_02_slime")
   -- PrecacheParticleSystem("antlion_gib_02_juice")
-- end

--[[
-----------------------------------------------------------------------------------------------------
Convars
-----------------------------------------------------------------------------------------------------
]]

-- if CLIENT then
	-- CreateClientConVar("cl_eftmeds_quick", "0", true, false)
-- end

--[[
-----------------------------------------------------------------------------------------------------
Ammo Tables
-----------------------------------------------------------------------------------------------------
]]

game.AddAmmoType( {
name = "carfirstaidkit",
} )
game.AddAmmoType( {
name = "salewafirstaidkit",
} )
game.AddAmmoType( {
name = "cattourniquet",
} )
game.AddAmmoType( {
name = "augmentin",
} )
game.AddAmmoType( {
name = "grizzlykit",
} )
game.AddAmmoType( {
name = "surgicalkit",
} )
game.AddAmmoType( {
name = "alusplint",
} )
game.AddAmmoType( {
name = "afak",
} )
game.AddAmmoType( {
name = "injectoradrenaline",
} )
game.AddAmmoType( {
name = "morphine",
} )
game.AddAmmoType( {
name = "l1",
} )
game.AddAmmoType( {
name = "trimadol",
} )
game.AddAmmoType( {
name = "propital",
} )
game.AddAmmoType( {
name = "etg",
} )
game.AddAmmoType( {
name = "tg12",
} )
game.AddAmmoType( {
name = "anaglin",
} )
game.AddAmmoType( {
name = "esmarch",
} )

--[[
-----------------------------------------------------------------------------------------------------
Sound Tables
-----------------------------------------------------------------------------------------------------
]]

---- 

----------------------------------------------------------------------------------------- Other

--------------------------------------- Grizzly
sound.Add( {
    name = "MedsGrizzly.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/grizzly/item_medkit_grizzly_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsGrizzly.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/grizzly/item_medkit_grizzly_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsGrizzly.Take",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/grizzly/item_medkit_grizzly_02_medtake.wav",
    }
} )

--------------------------------------- Bandage
sound.Add( {
    name = "MedsBandage.Open",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/bandage/item_bandage_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsBandage.Take",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/bandage/item_bandage_02_bandagetake.wav",
    }
} )
sound.Add( {
    name = "MedsBandage.Use",
    channel = CHAN_WEAPON,
    volume = 0.4,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/bandage/item_bandage_03_use.wav",
    }
} )
sound.Add( {
    name = "MedsBandage.End",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/bandage/item_bandage_04_end.wav",
    }
} )

--------------------------------------- Medkit
sound.Add( {
    name = "MedsMedkit.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Take",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_02_takesyringe.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Kolpa",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_03_kolpachok.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Injection",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_04_injection.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Throw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_05_throwsyringe.wav",
    }
} )
sound.Add( {
    name = "MedsMedkit.Putaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/medkit/item_medkit_ai_06_putaway.wav",
    }
} )

--------------------------------------- Pills
sound.Add( {
    name = "MedsBlister.Draw",
    channel = CHAN_BODY,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/pills/item_pillsblister_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsBlister.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/eft/pills/item_pillsblister_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 110},
    sound = {
        "weapons/eft/pills/item_pillsbottle_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/eft/pills/item_pillsbottle_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Pilltake",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/eft/pills/item_pillsbottle_02_pilltake.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Use",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/eft/pills/item_pillsbottle_03_use.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Close",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/eft/pills/item_pillsbottle_04_close.wav",
    }
} )
sound.Add( {
    name = "MedsPillsBottle.Putaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/pills/item_pillsbottle_05_putaway.wav",
    }
} )

--------------------------------------- Salewa
sound.Add( {
    name = "MedsSalewa.Draw",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/salewa/item_medkit_salewa_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsSalewa.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/salewa/item_medkit_salewa_01_open.wav",
    }
} )
sound.Add( {
    name = "MedsSalewa.Bandage",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/salewa/item_medkit_salewa_02_bandagetake.wav",
    }
} )
sound.Add( {
    name = "MedsSalewa.Use",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/salewa/item_medkit_salewa_03_use.wav",
    }
} )
sound.Add( {
    name = "MedsSalewa.End",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/salewa/item_medkit_salewa_04_end.wav",
    }
} )

--------------------------------------- CAT
sound.Add( {
    name = "MedsCat.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/cat/item_cat_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsCat.Use",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/cat/item_cat_01_use.wav",
    }
} )
sound.Add( {
    name = "MedsCat.Fasten",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/cat/item_cat_02_fasten.wav",
    }
} )
sound.Add( {
    name = "MedsCat.Putaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/cat/item_cat_03_putaway.wav",
    }
} )

--------------------------------------- Medkit
sound.Add( {
    name = "MedsSurgical.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.SicDraw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_01_scissors_draw.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.SciUse",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_02_scissors_use.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.SciPutaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_03_scissors_putaway.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.PickDraw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_04_picker_draw.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.PickUse",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_05_picker_use.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.PickPutaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_06_picker_putaway.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.StaplerDraw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_07_stapler_draw.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.StaperUse",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_08_stapler_use.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.StaplerPutaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_09_stapler_putaway.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.Close",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_10_close.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.Button1",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_11_close_button.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.Button2",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_12_close_button.wav",
    }
} )
sound.Add( {
    name = "MedsSurgical.Putaway",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/surgicalkit/item_surgicalkit_13_putaway.wav",
    }
} )

--------------------------------------- Splint
sound.Add( {
    name = "MedsSplint.Start",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/splint/item_splint_00_start.wav",
    }
} )
sound.Add( {
    name = "MedsSplint.Middle",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/splint/item_splint_01_middle.wav",
    }
} )
sound.Add( {
    name = "MedsSplint.End",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/splint/item_splint_02_end.wav",
    }
} )

--------------------------------------- Splint
sound.Add( {
    name = "MedsInjector.Draw",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/injector/item_injector_00_draw.wav",
    }
} )
sound.Add( {
    name = "MedsInjector.Open",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/injector/item_injector_01_kolpachok.wav",
    }
} )
sound.Add( {
    name = "MedsInjector.Use",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/injector/item_injector_02_injection.wav",
    }
} )
sound.Add( {
    name = "MedsInjector.End",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 65,
    pitch = {95, 115},
    sound = {
        "weapons/eft/injector/item_injector_03_putaway.wav",
    }
} )