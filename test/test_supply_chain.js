const SupplyChain = artifacts.require("SupplyChain")

contract("SupplyChain", ()=>{

    before(async ()=>{
        this.supplyChain = await SupplyChain.deployed()
    })

    it("add user", async () => {
        const result  = await this.supplyChain.registerUser("victor_supplier","prueba_lugar",1,"0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        const registerEvent = result.logs[0].args;
        assert.equal(registerEvent.name, "victor_supplier");
        assert.equal(registerEvent.userLoc, "prueba_lugar");
        assert.equal(registerEvent.role, 1);
        assert.equal(registerEvent.userAddr, "0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7");
    })

    it("supplier Creates Raw Package", async () => {
        
        const result  = await this.supplyChain.supplierCreatesRawPackage("madera", 20,"0x856038774c780cAC2Ca22f8187Ef79A3b9b650ec","0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B","0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        assert.notEqual(result, null);
        assert.notEqual(result, undefined);
        assert.notEqual(result, 0x0);
        assert.notEqual(result, "");
    })

    it("get raw materials for supplier", async () =>{
        const result = await this.supplyChain.getAllPackages("0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        const lengthResult = result.length
        assert.equal(lengthResult, 1);
    })

    it("transporter handle package", async () =>{
        await this.supplyChain.registerUser("victor_trasnporter","prueba_lugar",2,"0x856038774c780cAC2Ca22f8187Ef79A3b9b650ec")
        const listSupplierPackage = await this.supplyChain.getAllPackages("0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        const result = await this.supplyChain.transporterHandlePackage(listSupplierPackage[0],1,"0x856038774c780cAC2Ca22f8187Ef79A3b9b650ec")
        assert.notEqual(result, null);
        assert.notEqual(result, undefined);
        assert.notEqual(result, 0x0);
        assert.notEqual(result, "");
    })

    it("manufacturer received raw materials", async () =>{
        await this.supplyChain.registerUser("victor_manufacturer","prueba_lugar",3,"0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B")
        const listSupplierPackage = await this.supplyChain.getAllPackages("0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        const result = await this.supplyChain.manufacturerReceivedRawMaterials(listSupplierPackage[0],"0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B")
        assert.notEqual(result, null);
        assert.notEqual(result, undefined);
        assert.notEqual(result, 0x0);
        assert.notEqual(result, "");
    })

    it("manufacturer creates product", async () =>{
        await this.supplyChain.registerUser("victor_wholesaler","prueba_lugar",4,"0x3dd4330Bd3baa5d4cAe4329e511Fc5a974D0Fb25")
        const listSupplierPackage = await this.supplyChain.getAllPackages("0x6b5bAbA6290D65B7312A5bCcE5555c274d3998b7")
        const result = await this.supplyChain.manufacturerCreatesNewItemProducto(
            "product1",
            listSupplierPackage,
            1,
            ["0x856038774c780cAC2Ca22f8187Ef79A3b9b650ec"],
            "0x3dd4330Bd3baa5d4cAe4329e511Fc5a974D0Fb25"
            )
        const listManufacturerProduct = await this.supplyChain.getAllProducts("0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B")
        assert.equal(listManufacturerProduct.length, 1);
    })

    it("transporter product", async () =>{
        const listManufacturerProduct = await this.supplyChain.getAllProducts("0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B")
        const result = await this.supplyChain.transporterHandlePackage(listManufacturerProduct[0],2,"0x856038774c780cAC2Ca22f8187Ef79A3b9b650ec")
        
        assert.notEqual(result, null);
        assert.notEqual(result, undefined);
        assert.notEqual(result, 0x0);
        assert.notEqual(result, "");
    })

    it("wholesaler", async () =>{
        const listManufacturerProduct = await this.supplyChain.getAllProducts("0x80f48D5bcCdA0B7bB93c16e8DA2416B132E1673B")
        const result = await this.supplyChain.wholesalerReceivedProduct(listManufacturerProduct[0], "0x3dd4330Bd3baa5d4cAe4329e511Fc5a974D0Fb25" )
        listProductsRecevied = await this.supplyChain.getAllProductsAtWholesaler("0x3dd4330Bd3baa5d4cAe4329e511Fc5a974D0Fb25")
        assert.equal(listProductsRecevied.length, 1);
    })
})