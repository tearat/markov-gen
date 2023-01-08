const Markov = require("js-markov")
const fs = require("fs")
const states = require("./output/states")

var markov = new Markov()
markov.setType("text")

const preparedText = states.split(/[\n.]+/)

markov.addStates([...preparedText])

markov.setOrder(10)
markov.train()

const output = `const markovTrained = ${JSON.stringify(markov)}`

fs.writeFileSync("./output/markov.js", output, {
  encoding: "utf8",
  flag: "w",
})
