import React from 'react';

export default function TestComponent() {
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-3xl font-bold text-blue-600 mb-4">
        Tailwind CSS in React
      </h1>
      <div className="bg-white rounded-lg shadow-md p-6">
        <p className="text-gray-700 mb-4">
          This is a test component to verify Tailwind CSS LSP in JSX.
        </p>
        <button className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded transition-colors">
          Click me
        </button>
        {/* Try adding classes here to test autocomplete */}
        <div className="">
          
        </div>
      </div>
    </div>
  );
}
