import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import cloud9Setup from './cloud9Setup'
import clubs from './clubs'
import leaderIntake from './leaderIntake'
import { reducer as form } from 'redux-form'

export default combineReducers({
  routing: routerReducer,
  cloud9Setup,
  clubs,
  leaderIntake,
  form
})
