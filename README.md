# ETH / Subexponential SAT 独立 Lean 项目

这是原仓库中 **The Exponential Time Hypothesis is False** 对应形式化代码的独立抽取版。
保留 `OAI.Algorithms.SubexponentialSAT.Main` 的完整本地 import 闭包，共 3,091 个模块；
源文件保持原样，外部直接依赖只有固定版本的 Mathlib，不依赖父目录项目。

验证状态：2026-11-05 按用户要求停止本地构建。停止时已生成 1,664 / 3,091
个本地模块的编译产物，日志未出现编译错误，但完整构建及最终定理的公理审计
尚未完成。本项目的上传不表示已通过完整验证。

## 构建

需要 Elan、Git，以及首次安装依赖时的网络连接。Lean 版本固定为 `v4.34.1`，
Mathlib 固定为 `d13f23b723b8a846827a245b89c10fc7d3f11612`。

```bash
cd eth-standalone
export LEAN_NUM_THREADS=1
nice -n 19 lake exe cache get
nice -n 19 lake build
```

也可以运行 `./build.sh`：该脚本设置 `LEAN_NUM_THREADS=1`，然后执行
`nice -n 19 lake build`。本项目 Lean 编译参数也设置为 `-j1`。
`nice` 降低 CPU 调度优先级，不是内存上限；首次完整验证包含数千个模块，可能耗时很长。
重复运行构建会利用已有产物继续。

## 入口与结论范围

- `ETH.lean`：默认构建入口，导入真实证明并打印三个最终定理依赖的公理。
- `OAI/Algorithms/SubexponentialSAT/Main.lean`：原项目完整入口。
- `OAI/Algorithms/SubexponentialSAT/SqrtLogSpace/Final.lean`：精确计数、SAT 和多项式空间结论。
- `docs/original-scope.md`：原仓库的范围说明（其中论文与 comparator 链接属于原仓库）。

`exact_count_and_sat` 陈述：对每个固定 `k ≥ 2`，存在一台固定的确定性机器，
对规范编码的 `k`-CNF 精确计算满足赋值数量，并给出 SAT 答案；运行时间界为
`(L+1)^O_k(1) · 2^O_k(n (log log n)^2 / sqrt(log n))`，
每个执行前缀访问的磁带空间为 `(L+1)^O_k(1)`。这里 `L` 是编码长度。
这就是该项目所主张的 ETH 证伪结果所对应的算法结论。

原仓库 `ComparatorChallenges/SubexponentialSAT.lean` 是含 `sorry` 的挑战陈述，
本项目不复制也不导入它。证明入口与挑战文件定义的同名定理不能混为一谈。
完成构建后，应检查最终 `#print axioms` 输出是否只含
`propext`、`Classical.choice`、`Quot.sound`，且不含 `sorryAx` 或额外公理。
构建验证的是 Lean 中的精确陈述；对它与通常 ETH 定义、编码及计算模型的对应关系，
仍需审阅这些定义，不能仅凭论文标题或文件存在作出判断。

## 来源

源仓库提交：`7ef5c0cc5ca4b0e072b7a050fca09ab24bc6fa3a`。
`source-manifest.json` 记录抽取模块与每个实际复制文件的 SHA-256，可核对原文。
沿用原仓库 Apache-2.0 许可证，见 `LICENSE`。
