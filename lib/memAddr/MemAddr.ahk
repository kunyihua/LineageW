Class MemAddr {

    __New(object) {

        this.ojb := object

        this.MyCharacter_Base := 0x0709B9A0
            
        this.HP_offset := [0x30, 0x228, 0x52C]
        this.MP_offset := [0x30, 0x228, 0x770]

        this.MyPosition_X_offset := [0x30, 0x648]
        this.MyPosition_Y_offset := [0x30, 0x64C]

        this.BagOpen_Base := 0x683A134
        

        this.HPAddr := this.ojb.getAddressFromOffsets(this.ojb.baseAddress + this.MyCharacter_Base, this.HP_offset*)
        this.MPAddr := this.ojb.getAddressFromOffsets(this.ojb.baseAddress + this.MyCharacter_Base, this.MP_offset*)
        this.MyPosition_XAddr := this.ojb.getAddressFromOffsets(this.ojb.baseAddress + this.MyCharacter_Base, this.MyPosition_X_offset*)
        this.MyPosition_YAddr := this.ojb.getAddressFromOffsets(this.ojb.baseAddress + this.MyCharacter_Base, this.MyPosition_Y_offset*)
        
    }
}