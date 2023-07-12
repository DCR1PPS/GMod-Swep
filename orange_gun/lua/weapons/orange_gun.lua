SWEP.PrintName = "Orange Gun"
    
SWEP.Author = "DCR1PPS"
SWEP.Purpose = "You pass butter."
SWEP.Instructions = "MOUSE1 to fire."
SWEP.Category = "DCR1PPS' Sweps"

SWEP.Spawnable= true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

local ShootSound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Damage = 6
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 36
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.DefaultClip = 36
SWEP.Primary.Spread = 0.5
SWEP.Primary.NumberofShots = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.2
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo	= "none"

SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.HoldType = "Pistol"

SWEP.FiresUnderwater = true

SWEP.ReloadSound = "weapons/pistol/pistol_reload1.wav"

SWEP.CSMuzzleFlashes = true

function SWEP:Initialize()
    util.PrecacheSound(ShootSound)
    util.PrecacheSound(self.ReloadSound)
    self:SetWeaponHoldType(self.HoldType)
end 

function SWEP:PrimaryAttack()
    if (!self:CanPrimaryAttack()) then return end
     
    local bullet = {}
    bullet.Num = self.Primary.NumberofShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = self.Primary.Force
    bullet.Damage = self.Primary.Damage
    bullet.AmmoType = self.Primary.Ammo
     
    local rnda = self.Primary.Recoil * -1
    local rndb = self.Primary.Recoil * math.random(-1, 1)
     
    self:ShootEffects()
     
    self.Owner:FireBullets(bullet)
    self:EmitSound(ShootSound)
    self.Owner:ViewPunch(Angle(rnda,rndb,rnda))
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
     
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end 

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end