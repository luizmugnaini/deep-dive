# Deep-Dive

Deep-Dive is just a poetic name to a compilation of notes that I'm writing
while studying mathematics and related fields. They currently encompass the
following topics:

- Category Theory
- Linear Algebra
- Group Theory
- Ring Theory
- Module Theory
- Classical Topology
- Algebraic Topology
- Abstract Homotopy Theory
- Graph Theory
- Manifold Theory
- Real Analysis
- Statistics, Probability and Machine Learning

I'm a category theory junky so expect _a lot_ of abstraction and commutative
diagrams. If you are into that, I think you may find these notes at the very
least interesting for your taste.

If you want to have a peek at the actual document, you can find a _certainly
out-of-date_ compiled version [in my website](https://luizmugnaini.github.io/deep-dive.pdf).
If you want to hear more about the story behind these notes, you may take a look at
[this blog post](https://luizmugnaini.github.io/deep-dive/).

## Disclaimer

_None_ of these subjects are completed _and will never be_ (for trivial reasons),
however the notes already have _about 700 pages_.

If you happen to compile them and find them helpful or stupid in some way (and
if you're willing to help), reach me out and I'll be quite happy to have some
feedback.

> I won't accept any pull-requests. Mind you, these are my personal notes for
> my own learning process.

## Requirements

- A LaTeX distribution (I've tested with TeXLive and MiKTeX already and both work).
- [Make](https://www.gnu.org/software/make/) if you're on Linux.
- [LaTeXMk](https://archlinux.org/packages/extra/any/texlive-binextra/) for building.
- [latexindent.pl](https://github.com/cmhughes/latexindent.pl/) for formatting.

## Usage

```bash
git clone https://github.com/luizmugnaini/deep-dive
cd deep-dive
make build  # single build
make watch  # continuous build as files are changed
make format # format the tex files with latexindent.pl
```

# Troubleshooting

* Did you get some strange "font not loadable" or something along those lines?
  You are probably lacking Japanese support in your latex installation (used
  for the Yoneda functor symbol) you may give a try installing `ckj-fonts`.
