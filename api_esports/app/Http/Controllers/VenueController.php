<?php

namespace App\Http\Controllers;

use App\Models\Venue;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\VenueRequest;

class VenueController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Venue::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(VenueRequest $request)
    {
        $venue = new Venue();
        $venue->name = $request->name;
        $venue->city = $request->city;
        $venue->save();
        return $venue;
    }

    /**
     * Display the specified resource.
     */
    public function show(Venue $venue)
    {
        return $venue;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Venue $venue)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(VenueRequest $request, Venue $venue)
    {
        $venue->name = $request->name;
        $venue->city = $request->city;
        $venue->save();
        return $venue;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Venue $venue)
    {
        return $venue->delete();
    }
}
