# Fibonacci-function-on-FPGA

The Fibonacci function is defined as

![image](https://user-images.githubusercontent.com/117464811/232430447-f4d76269-09cf-4a13-9502-365223babefe.png)

Assume that n is a 6-bit input and interpreted as an `unsigned integer`. Note that fib(63) is 6557470319842.

## pre-lab

### Pseudo-code

```
if(n_in=0) then{
fb0:
	fb1=0;
	fb2=0;
	n=0;
}else{
	if(n_in=1) then{
fb1:
		fb1=0;
		fb2=1;
		n=1;
	}else{
load:
		fb1=1;
		fb2=1;
		n=2;
if:
		if(n=n_in-1) then{
			goto idle;
		}else{
op:
			n=n--;
			fb1=fb2;
			fb2=fb1+fb2;
			goto if;
		}
	}
}
```

### algorithm state machine chart

![44A7FCD57DFA99E1684203BB23BB7C4A](https://user-images.githubusercontent.com/117464811/234206363-bad93d54-f801-4605-a97b-8aa01d41358a.png)

### conceptual diagram

![IMG_1666](https://user-images.githubusercontent.com/117464811/234206439-7cca4a53-c7ef-4236-b004-e13699b15ae9.PNG)

## simulation

Develop the VHDL code in two-segment style. Simulate the VHDL model.

### behavioral

The result of behavioral simulation is as expected.

![1_1](https://github.com/HuaYuXiao/Fibonacci-function-on-FPGA/assets/117464811/85538985-adcd-4b3e-859e-f95e76e07021)

![1_2](https://github.com/HuaYuXiao/Fibonacci-function-on-FPGA/assets/117464811/c45a14d2-af28-469d-a2f6-058a5bf3d9b2)

Since the whole output series is relatively long, here we skip to the end of the output.

![1_4](https://github.com/HuaYuXiao/Fibonacci-function-on-FPGA/assets/117464811/c78b545d-62b8-4cbd-a64e-3f44f7baddec)

### post-synthesis

post-synthesis functional simulation:



post-synthesis timing simulation:




### post-implementation



In this project, we use registers to store the first two items of the Fibonacci sequence and calculate the next term through combinatorial logic. However, combinatorial logic consumes a lot of resources and takes up a lot of LUT resources in FPGAs, resulting in poor scalability of the design.

To optimize this problem, sharing on a repetitive-addition adder can be used. This method can use the DSP block in the FPGA to realize the multiplexing of the adder, thereby greatly improving the computational efficiency.

By adopting this approach, the amount of combinatorial logic can be reduced, thereby saving LUT resources in the FPGA, and the DSP block can be used to implement efficient adders and improve computational efficiency. This approach can greatly improve the computational speed of Fibonacci sequences and improve the scalability of the design.

## implementation

Implement this function on the FPGA board. You may design the input/output interfaces.

## Conclusion


