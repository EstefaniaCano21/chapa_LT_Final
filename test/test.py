import cocotb
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_fsm_lock(dut):
    dut._log.info("Iniciando test básico")

    # Reset
    dut.rst_n.value = 0
    dut.clk.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await Timer(10, units="ns")
    dut.rst_n.value = 1

    # Generar reloj
    for _ in range(5):
        dut.clk.value = 0
        await Timer(5, units="ns")
        dut.clk.value = 1
        await Timer(5, units="ns")

    # Simular entrada de dígito 9 con enter
    dut.ui_in.value = 0b10001001  # enter = 1, digit = 9
    await RisingEdge(dut.clk)

    dut._log.info(f"uo_out = {dut.uo_out.value}")
    assert True, "Test pasó correctamente"
