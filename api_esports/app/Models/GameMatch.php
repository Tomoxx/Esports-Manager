<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GameMatch extends Model
{
    use HasFactory;
    protected $table = 'matches';
    // Define mutators for date fields
    protected $dates = ['match_date'];

    // Mutator to format date when setting attribute
    public function setMatchDateAttribute($value)
    {
        $this->attributes['match_date'] = \Carbon\Carbon::parse($value)->format('Y-m-d H:i');
    }

    // Accessor to format date when retrieving attribute
    public function getMatchDateAttribute($value)
    {
        return \Carbon\Carbon::parse($value)->format('Y-m-d H:i');
    }
    public function tournament(): BelongsTo
    {
        return $this->belongsTo(Tournament::class);
    }
    public function homeTeam(): BelongsTo
    {
        return $this->belongsTo(Team::class);
    }
    public function awayTeam(): BelongsTo
    {
        return $this->belongsTo(Team::class);
    }
    public function venue(): BelongsTo
    {
        return $this->belongsTo(Venue::class);
    }
}
