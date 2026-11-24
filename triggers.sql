USE pizzaria;

DROP TRIGGER IF EXISTS atualizaValorPedido;

DELIMITER //

CREATE TRIGGER atualizaValorPedido
AFTER INSERT
ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE pedidos
    SET valor = (
        SELECT SUM(valor * quantidade)
        FROM itens_pedido
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE pedido_id = NEW.pedido_id;
END//

DELIMITER ;