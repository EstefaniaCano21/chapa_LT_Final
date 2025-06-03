import cocotb
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_fsm_lock(dut):
    dut._log.info("Iniciando test robusto para gate-level")

    # Inicialización
    dut.rst_n.value = 0
    dut.clk.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Esperar reset
    await Timer(100, units="ns")
    dut.rst_n.value = 1

    # Generar reloj
    for _ in range(20):
        dut.clk.value = 0
        await Timer(10, units="ns")  # reloj más lento
        dut.clk.value = 1
        await Timer(10, units="ns")

    # Simular ingreso del primer dígito correcto (9)
    dut.ui_in.value = 0b10001001  # enter=1, digit=9
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0           # quitar enter
    await RisingEdge(dut.clk)

    # Segundo dígito
    dut.ui_in.value = 0b10001001
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0
    await RisingEdge(dut.clk)

    # Tercer dígito (7)
    dut.ui_in.value = 0b10000111
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0
    await RisingEdge(dut.clk)

    # Cuarto dígito (9)
    dut.ui_in.value = 0b10001001
    await RisingEdge(dut.clk)
    dut.ui_in.value = 0
    await RisingEdge(dut.clk)

    dut._log.info(f"Salidas después del PIN completo: uo_out = {dut.uo_out.value}")
    
    # Verificar si LED de desbloqueo está activo (uo_out[1] == 1)
    assert dut.uo_out.value & 0b10, "Error: LED de desbloqueo no activo después del PIN correcto"
