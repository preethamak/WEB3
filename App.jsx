import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Chai from './hlo'
import Cal from './Cal'

function App() {
  const [count, setCount] = useState(0)

  return (
   <div>
    <Chai/>
    <Cal/>
    <h1>Hello Buddy</h1>
    </div>
  )
}

export default App
