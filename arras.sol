// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.1;

contract Arras {
    
    enum Tipo    {confirmatorias, penales, penitenciales}
    enum Firmado {noFirmado, firmadoVendedor, firmadoComprador}
    Tipo    public tipo;
    string  public referencia;  // Web con la venta, anuncio, etc
    uint    public importe;     // Del contrato de arras (wei)
    uint    public precio;      // De la venta (€)
    string  public vencimiento; // Del contrato de arras
    Firmado public firmado;

    function getInfo() public view returns (Tipo, string memory, uint, uint, uint256, Firmado) {
        return (tipo, referencia, importe, precio, vencimiento, firmado);
    }

    function firmaVendedor(Tipo _tipo, string memory _referencia, uint _importe, uint _precio,string memory _vencimiento) public {
        require(firmado == Firmado.noFirmado, "Esperando firma comprador o contrato finalizado");
        require(_importe > 0, "El importe del contrato tiene que ser mayor que cero");
        tipo        = _tipo;
        referencia  = _referencia;
        importe     = _importe;
        precio      = _precio;
        vencimiento = _vencimiento;
        firmado     = Firmado.firmadoVendedor;
    }

    function firmaComprador() public payable {
        require(firmado == Firmado.firmadoVendedor, "Esperando firma vendedor o contrato finalizado");
        require(msg.value == importe, "Importe a pagar no corresponde con el importe enviado"); // Solo puede enviarse la cantidad exacta del contrato
        firmado = Firmado.firmadoComprador;
    }
}