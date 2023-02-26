import React from 'react';
import App from './../app.jsx';

import Home from './../pages/home/home.js';

const AppRoute = [
  {
    path: '*', 
    element: <App />,
    children: [
    	{
				path: '', 
				element: <Home />
			}
		]
  }
];


export default AppRoute;