const { ApolloServer } = require('apollo-server')
const { typeDefs, resolvers } = require('./schema')

const myPlugin = {
  // Fires whenever a GraphQL request is received from a client.
  requestDidStart(requestContext) {
    console.log('Request started! Query:\n' + requestContext.request.query)
  },
}

const server = new ApolloServer({
  typeDefs,
  resolvers,
  // plugins: [myPlugin],
})

server.listen().then(({ url }) => {
  console.log(`🚀  Servers ready at ${url}`)
})
