// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.1;

contract CompraVenta {
    
    enum Estado {creado, pagado, cancelado}
    Estado  estado;
    address vendedor;
    string  concepto;
    uint256 precio; // WEIs

    constructor (string memory _concepto, uint256 _precio) { // Clonar
        vendedor = msg.sender;
        estado   = Estado.creado;
        concepto = _concepto;
        precio   = _precio;
    }

    function getInfo() public view returns (Estado, string memory, uint256) {
        return (estado, concepto, precio);
    }

    function cancelar() public {
        require(estado == Estado.creado, "El contrato necesita estar vigente");
        require(vendedor == msg.sender, "Solo el vendedor puede cancelar el contrato");
        estado = Estado.cancelado;
    }

    function reanudar() public {
        require(estado == Estado.cancelado, "El contrato necesita estar cancelado");
        require(vendedor == msg.sender, "Solo el vendedor puede reanudar el contrato");
        estado = Estado.creado;
    }

    function pagar() public payable {
        require(estado == Estado.creado, "El contrato no esta vigente");
        require(vendedor != msg.sender, "El vendedor no puede ser el comprador");
        require(msg.value == precio, "Cantidad no coincide con el precio");
        estado = Estado.pagado;
    }
}