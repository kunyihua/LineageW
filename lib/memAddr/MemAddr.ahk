Class MemAddr {

    __New(object) {

        this.obj := object

        this.LocalPlayer := 0x07026DE0
            
        this.HP_offset := [0x30, 0x228, 0x52C]
        this.MP_offset := [0x30, 0x228, 0x770]

        this.MyPosition_X_offset := [0x30, 0x648]
        this.MyPosition_Y_offset := [0x30, 0x64C]

        this.BagOpen_Base := 0x67E50D8
        

        this.HPAddr := this.obj.getAddressFromOffsets(this.obj.baseAddress + this.LocalPlayer, this.HP_offset*)
        this.MPAddr := this.obj.getAddressFromOffsets(this.obj.baseAddress + this.LocalPlayer, this.MP_offset*)
        this.MyPosition_XAddr := this.obj.getAddressFromOffsets(this.obj.baseAddress + this.LocalPlayer, this.MyPosition_X_offset*)
        this.MyPosition_YAddr := this.obj.getAddressFromOffsets(this.obj.baseAddress + this.LocalPlayer, this.MyPosition_Y_offset*)
        
    }

    __delete() {
        this.obj := ""
    }
}
